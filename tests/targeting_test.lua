-- The #BID / #TELL targeting rule in both modes, run on the host with stand-ins for Mudlet.
--     lua5.1 tests/targeting_test.lua
local xml = io.open("cpc.xml"):read("*a")
local script
for body in xml:gmatch("<script>(.-)</script>") do
  if #body > (script and #script or 0) then script = body end
end
script = script:gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&quot;", '"'):gsub("&amp;", "&")

local profiles, out = {}, {}
function getProfiles() return profiles end
function getProfileName() return "Mage-Test" end
function cecho(s) out[#out + 1] = s end
function echo(s) out[#out + 1] = s end
function registerAnonymousEventHandler() return 1 end
function killAnonymousEventHandler() end
function downloadFile() end
function io.exists() return true end
lfs = { mkdir = function() end }
function getMudletHomeDir() return "/tmp" end
function table.load() end
function table.index_of(t, v) for i, x in ipairs(t) do if x == v then return i end end end
function expandAlias() end
string.ends = function(s, e) return e == "" or s:sub(-#e) == e end

assert(loadstring(script))()

local fails = 0
local function check(cond, what)
  if cond then print("ok:   " .. what) else fails = fails + 1; print("FAIL: " .. what) end
end
local function open(...) profiles = {}; for _, n in ipairs({...}) do profiles[n] = { loaded = true } end; out = {} end

-- default: upstream's substring match, every profile decides for itself
check(cpc.strictTargets == false, "strictTargets is off by default")
open("Mage-Test", "Mage-Other")
check(cpc:isTarget("mage", true) == true and #out == 0, "default: a part shared by several profiles reaches this one too, silently")
check(cpc:isTarget("Mage-Test", true) == true, "default: the exact name reaches it")
check(cpc:isTarget("other", true) == false, "default: a part of another name does not")
check(cpc:isTarget("", true) == true, "default: an empty target reaches everyone, as upstream")

-- strict: at most one profile
cpc.strictTargets = true
open("Mage-Test", "Mage-Other", "Cleric-Curick")
check(cpc:isTarget("Mage-Test", true) == true, "strict: exact name, any case, reaches this profile")
check(cpc:isTarget("mage-other", true) == false, "strict: exact name of another profile does not")
check(cpc:isTarget("test", true) == true, "strict: a part only this profile's name contains reaches it")
out = {}
check(cpc:isTarget("other", true) == false and #out == 0, "strict: a part only another profile contains: silent here")
out = {}
check(cpc:isTarget("mage", true) == false and out[1] and out[1]:find("matches 2 open profiles") and out[1]:find("Mage%-Other, Mage%-Test"),
  "strict: an ambiguous part reaches nobody and the sender lists the matches, sorted")
out = {}
check(cpc:isTarget("mage", false) == false and #out == 0, "strict: the same ambiguity arriving as a global event prints nothing")
out = {}
check(cpc:isTarget("zzz", true) == false and out[1] and out[1]:find("no open profile matches 'zzz'"), "strict: no match is reported in the sender")
out = {}
check(cpc:isTarget("", true) == false and #out == 0, "strict: an empty target does nothing")
profiles["Mage-Other"].loaded = false
out = {}
check(cpc:isTarget("mage", true) == true, "strict: a profile that is not loaded does not count as a match")

if fails > 0 then print(fails .. " failed"); os.exit(1) end
print("all passed")
