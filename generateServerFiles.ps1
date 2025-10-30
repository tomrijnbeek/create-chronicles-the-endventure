### Variables
# Mod blacklist to NOT copy into serve side folder
$MOD_BLACK_LIST="gpumemleakfix*", "maptooltip-neoforge*", "probejs*", "moreoverlays*", "MouseTweaks*", "EquipmentCompare*", "Prism*", "Boat-Item-View*", "LegendaryTooltips*", "Highlighter*", "Ding*", "AmbientSounds*", "fancymenu*", "OverflowingBars*","AmbientSounds_NEOFORGE*", "drippyloadingscreen*","melody_neoforge_*","foodeffecttooltips*","enchdesc*","clientcrafting*", "auroras*", "BetterThirdPerson*", "iris-neoforge*", "ImmediatelyFast*","sodium-neoforge-*","jmi-neoforge*","BHMenu-NeoForge*","Immersive-UI*","BadOptimizations*","farsight*", "cherishworlds*", "BetterAdvancements*","modernworldcreation_*","Controlling-*","StylishEffects*","Better Tags*"

# Folder list to copy
$FOLDER_LIST= @("mods", "kubejs", "config")

$SERVER_FOLDER="server_files"
$CURRENT_FOLDER=$PWD

Write-Output "Starting Server generation."

if (Test-Path -Path $CURRENT_FOLDER\$SERVER_FOLDER) {
    Remove-Item $CURRENT_FOLDER\$SERVER_FOLDER -Recurse -Force
}

New-Item -Path $CURRENT_FOLDER -Name $SERVER_FOLDER -ItemType "directory"

foreach ($folder in $FOLDER_LIST) {
    Copy-Item -Path $CURRENT_FOLDER\$folder\ -Destination $CURRENT_FOLDER\$SERVER_FOLDER -Recurse -Exclude $MOD_BLACK_LIST
}

# Copy "preServer" folder contents to "server_files"
$PRE_SERVER_FOLDER="preServer"
Copy-Item -Path $CURRENT_FOLDER\$PRE_SERVER_FOLDER\* -Destination $CURRENT_FOLDER\$SERVER_FOLDER -Recurse

Write-Output "Server generation finished."
