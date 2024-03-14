{ pkgs, ... }:

{
  home.packages = with pkgs; [ unstable.vesktop ];

  # home.file.".config/vesktop/settings/settings.json".text = builtins.toJSON {
  #   # General options
  #   enableReactDevtools = false;

  #   # Update
  #   autoUpdate = false;
  #   autoUpdateNotification = true;

  #   # Themes
  #   useQuickCss = true;
  #   themeLinks = [
  #     "https://raw.githubusercontent.com/refact0r/midnight-discord/master/flavors/midnight-vencord.theme.css"
  #     "https://raw.githubusercontent.com/DiscordStyles/HorizontalServerList/deploy/HorizontalServerList.theme.css"
  #     "https://raw.githubusercontent.com/DiscordStyles/RadialStatus/deploy/RadialStatus.theme.css"
  #     "https://nyri4.github.io/Discolored/support/discolored.theme.css"
  #   ];
  #   enabledThemes = [ ];

  #   # Window
  #   frameless = false;
  #   transparent = false;
  #   winCtrlQ = false;
  #   winNativeTitleBar = false;
  #   disableMinSize = false;

  #   # Notifications
  #   notifyAboutUpdates = true;
  #   notifications = {
  #     timeout = 5000;
  #     position = "bottom-right";
  #     useNative = "not-focused";
  #     logLimit = 50;
  #   };

  #   # Cloud
  #   cloud = {
  #     authenticated = false;
  #     url = "https://api.vencord.dev/";
  #     settingsSync = false;
  #     settingsSyncVersion = 1710353413646;
  #   };

  #   # plugins = let
  #   #   # tip: use the following command to get all disabled plugins
  #   #   # cat .config/vesktop/settings/settings.json | jq -r '.plugins | to_entries[] | select(.value.enabled == false) | .key'
  #   #   disabledPluginsList = [
  #   #     "ChatInputButtonAPI"
  #   #     "MemberListDecoratorsAPI"
  #   #     "MessageAccessoriesAPI"
  #   #     "MessageDecorationsAPI"
  #   #     "MessagePopoverAPI"
  #   #     "ServerListAPI"
  #   #     "AlwaysAnimate"
  #   #     "AlwaysTrust"
  #   #     "WebRichPresence (arRPC)"
  #   #     "BANger"
  #   #     "BetterFolders"
  #   #     "BetterGifAltText"
  #   #     "BetterNotesBox"
  #   #     "BetterRoleDot"
  #   #     "ClientTheme"
  #   #     "ColorSighted"
  #   #     "ConsoleShortcuts"
  #   #     "CustomRPC"
  #   #     "Decor"
  #   #     "DisableCallIdle"
  #   #     "EmoteCloner"
  #   #     "Experiments"
  #   #     "F8Break"
  #   #     "FakeProfileThemes"
  #   #     "FavoriteEmojiFirst"
  #   #     "FavoriteGifSearch"
  #   #     "FixSpotifyEmbeds"
  #   #     "FriendInvites"
  #   #     "GameActivityToggle"
  #   #     "GifPaste"
  #   #     "GreetStickerPicker"
  #   #     "HideAttachments"
  #   #     "iLoveSpam"
  #   #     "IgnoreActivities"
  #   #     "InvisibleChat"
  #   #     "KeepCurrentChannel"
  #   #     "LastFMRichPresence"
  #   #     "LoadingQuotes"
  #   #     "MemberCount"
  #   #     "MessageClickActions"
  #   #     "MessageLinkEmbeds"
  #   #     "MessageTags"
  #   #     "MoreCommands"
  #   #     "MoreKaomoji"
  #   #     "MoreUserTags"
  #   #     "Moyai"
  #   #     "NewGuildSettings"
  #   #     "NoBlockedMessages"
  #   #     "NoDevtoolsWarning"
  #   #     "NoF1"
  #   #     "NoMosaic"
  #   #     "NoPendingCount"
  #   #     "NoProfileThemes"
  #   #     "NoReplyMention"
  #   #     "NoScreensharePreview"
  #   #     "NoTypingAnimation"
  #   #     "NoUnblockToJump"
  #   #     "NSFWGateBypass"
  #   #     "oneko"
  #   #     "OpenInApp"
  #   #     "Party mode 🎉"
  #   #     "PermissionFreeWill"
  #   #     "PermissionsViewer"
  #   #     "petpet"
  #   #     "PictureInPicture"
  #   #     "PinDMs"
  #   #     "PlainFolderIcon"
  #   #     "PlatformIndicators"
  #   #     "PreviewMessage"
  #   #     "PronounDB"
  #   #     "QuickMention"
  #   #     "QuickReply"
  #   #     "ReactErrorDecoder"
  #   #     "ReadAllNotificationsButton"
  #   #     "RevealAllSpoilers"
  #   #     "ReviewDB"
  #   #     "RoleColorEverywhere"
  #   #     "SearchReply"
  #   #     "SecretRingToneEnabler"
  #   #     "SendTimestamps"
  #   #     "ServerListIndicators"
  #   #     "ServerProfile"
  #   #     "ShikiCodeblocks"
  #   #     "ShowAllMessageButtons"
  #   #     "ShowConnections"
  #   #     "ShowMeYourName"
  #   #     "ShowTimeouts"
  #   #     "SilentMessageToggle"
  #   #     "SilentTyping"
  #   #     "SortFriendRequests"
  #   #     "SpotifyControls"
  #   #     "SpotifyCrack"
  #   #     "SpotifyShareCommands"
  #   #     "StartupTimings"
  #   #     "SuperReactionTweaks"
  #   #     "TextReplace"
  #   #     "ThemeAttributes"
  #   #     "TimeBarAllActivities"
  #   #     "Translate"
  #   #     "TypingIndicator"
  #   #     "UnsuppressEmbeds"
  #   #     "UrbanDictionary"
  #   #     "UserVoiceShow"
  #   #     "USRBG"
  #   #     "ValidUser"
  #   #     "VcNarrator"
  #   #     "VencordToolbox"
  #   #     "ViewIcons"
  #   #     "ViewRaw"
  #   #     "VoiceMessages"
  #   #     "Wikisearch"
  #   #     "XSOverlay"
  #   #   ];

  #   #   disabledPlugins = builtins.listToAttrs
  #   #     (builtins.map (plugin: {
  #   #       "${plugin}" = {
  #   #         "enabled" = false;
  #   #       };
  #   #     }) disabledPluginsList
  #   #   );
  #   # in {
  #   #   # tip: use the following command to get all enabled plugins
  #   #   # cat .config/vesktop/settings/settings.json | jq '.plugins | to_entries[] | select(.value.enabled == true)'

  #   #   "BadgeAPI" = { "enabled" = true; };
  #   #   "CommandsAPI" = { "enabled" = true; };
  #   #   "ContextMenuAPI" = { "enabled" = true; };
  #   #   "MessageEventsAPI" = { "enabled" = true; };
  #   #   "NoticesAPI" = { "enabled" = true; };
  #   #   "NoTrack" = { "enabled" = true; };
  #   #   "Settings" = {
  #   #     "enabled" = true;
  #   #     "settingsLocation" = "aboveActivity";
  #   #   };
  #   #   "SupportHelper" = { "enabled" = true; };
  #   #   "AnonymiseFileNames" = {
  #   #     "enabled" = true;
  #   #     "anonymiseByDefault" = true;
  #   #     "method" = 0;
  #   #     "randomisedLength" = 7;
  #   #     "consistent" = "image";
  #   #   };
  #   #   "BetterGifPicker" = { "enabled" = true; };
  #   #   "BetterUploadButton" = { "enabled" = true; };
  #   #   "BiggerStreamPreview" = { "enabled" = true; };
  #   #   "BlurNSFW" = {
  #   #     "enabled" = true;
  #   #     "blurAmount" = 10;
  #   #   };
  #   #   "CallTimer" = { "enabled" = true; };
  #   #   "ClearURLs" = { "enabled" = true; };
  #   #   "CopyUserURLs" = { "enabled" = true; };
  #   #   "CrashHandler" = { "enabled" = true; };
  #   #   "Dearrow" = { "enabled" = true; };
  #   #   "FakeNitro" = {
  #   #     "enabled" = true;
  #   #     "enableEmojiBypass" = true;
  #   #     "emojiSize" = 48;
  #   #     "transformEmojis" = true;
  #   #     "enableStickerBypass" = true;
  #   #     "stickerSize" = 160;
  #   #     "transformStickers" = true;
  #   #     "transformCompoundSentence" = false;
  #   #     "enableStreamQualityBypass" = true;
  #   #     "useHyperLinks" = true;
  #   #     "hyperLinkText" = "{{NAME}}";
  #   #   };
  #   #   "FixCodeblockGap" = { "enabled" = true; };
  #   #   "FixYoutubeEmbeds" = { "enabled" = true; };
  #   #   "ForceOwnerCrown" = { "enabled" = true; };
  #   #   "ImageZoom" = { "enabled" = true; };
  #   #   "MessageLogger" = {
  #   #     "enabled" = true;
  #   #     "deleteStyle" = "text";
  #   #     "ignoreBots" = true;
  #   #     "ignoreSelf" = false;
  #   #     "ignoreUsers" = "";
  #   #     "ignoreChannels" = "";
  #   #     "ignoreGuilds" = "";
  #   #   };
  #   #   "MutualGroupDMs" = { "enabled" = true; };
  #   #   "NormalizeMessageLinks" = { "enabled" = true; };
  #   #   "NotificationVolume" = {
  #   #     "enabled" = true;
  #   #     "notificationVolume" = 50;
  #   #   };
  #   #   "OnePingPerDM" = {
  #   #     "enabled" = true;
  #   #     "channelToAffect" = "both_dms";
  #   #     "allowMentions" = true;
  #   #     "allowEveryone" = false;
  #   #   };
  #   #   "RelationshipNotifier" = {
  #   #     "enabled" = true;
  #   #     "notices" = false;
  #   #     "offlineRemovals" = true;
  #   #     "friends" = true;
  #   #     "friendRequestCancels" = true;
  #   #     "servers" = true;
  #   #     "groups" = true;
  #   #   };
  #   #   "ReverseImageSearch" = { "enabled" = true; };
  #   #   "ShowHiddenChannels" = {
  #   #     "enabled" = true;
  #   #     "hideUnreads" = true;
  #   #     "showMode" = 0;
  #   #     "defaultAllowedUsersAndRolesDropdownState" = true;
  #   #   };
  #   #   "TypingTweaks" = {
  #   #     "enabled" = true;
  #   #     "showAvatars" = true;
  #   #     "showRoleColors" = true;
  #   #     "alternativeFormatting" = true;
  #   #   };
  #   #   "Unindent" = { "enabled" = true; };
  #   #   "VoiceChatDoubleClick" = { "enabled" = true; };
  #   #   "WebContextMenus" = {
  #   #     "enabled" = true;
  #   #     "addBack" = true;
  #   #   };
  #   #   "WebKeybinds" = { "enabled" = true; };
  #   #   "WhoReacted" = { "enabled" = true; };
  #   # } // disabledPlugins;
  # };
}
