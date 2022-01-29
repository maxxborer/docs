# aGen Color Palette
set -l background 252633
set -l background_alpha 42435a
set -l foreground fcfcfc
set -l foreground_alpha cccccc
set -l selection 6770a0
set -l comment 565b74
set -l red ff2000
set -l orange f8b049
set -l yellow e8e41e
set -l green 12ee43
set -l purple ed2b82
set -l cyan 3ff3ff
set -l pink ff67be

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $purple
set -g fish_color_quote $green
set -g fish_color_redirection $foreground_alpha
set -g fish_color_end $cyan
set -g fish_color_error $red
set -g fish_color_param $orange
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment
set -g fish_color_cancel --background=$red
set -g fish_color_search_match --background=$selection

# Completion Pager Colors
set -g fish_pager_color_progress $background --background=$green
set -g fish_pager_color_prefix $orange
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$background_alpha
