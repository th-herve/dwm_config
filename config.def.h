/* See LICENSE file for copyright and license details. */
#include "exitdwm.c"
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int   borderpx    = 1; /* border pixel of windows */
static const unsigned int   snap        = 32;    /* snap pixel */
static const int            showbar     = 1;           /* 0 means no bar */
static const int            topbar      = 1;            /* 0 means bottom bar */
static const char           *fonts[]    = {"JetBrainsMono Nerd Font:size=10"};
static const char           dmenufont[] = "JetBrainsMono Nerd Font:size=10";
static const char           col_bg[]    = "#1E2326";
static const char           col_gray[]  = "#374145";
static const char           col_fg2[]   = "#495156";
static const char           col_fg[]    = "#D3C6AA";
static const char           col_high[]  = "#A7C080";

static const char           *colors[][3] = {
    /*                fg            bg          border   */
    [SchemeNorm]    = {col_fg,   col_bg,  col_gray},
    [SchemeSel]     = {col_high,    col_bg,  col_high},
};

/* tagging */
static const char *tags[]       = {"    ","","","","","","","",""};
static const char *alttags[]    = {"    󰪥","󰪥","󰪥","󰪥","󰪥","󰪥","󰪥","󰪥","󰪥"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class                instance        title           tags mask   isfloating  monitor */
    // {"firefox",             NULL,           NULL,           1 << 1,     0,          -1},
    {"Google-chrome",       NULL,           NULL,           1 << 2,     0,          -1},
    {"discord",             NULL,           NULL,           1 << 5,     0,          -1},
    {"Spotify",             NULL,           NULL,           1 << 6,     0,          -1},
    {"steam",               NULL,           NULL,           1 << 7,     0,          -1},
    {"Lutris",              NULL,           NULL,           1 << 7,     0,          -1},
    /*                                                                                          float x,y,w,h           floatborderpx */
    {"Gimp",                NULL,           NULL,           0,          1,          -1,         50,50,500,500,          -1},
    {"gnome-calculator",    NULL,           NULL,           0,          1,          -1,         1569, 20, 349, 492,     -1},
    {"calendar",            NULL,           NULL,           0,          1,          -1,         1628, 20, 290, 230,     -1},
    // firefox detachable video player
    { NULL,                 NULL,   "Picture-in-Picture",   -1,         1,          -1,         1327, 712, 591, 366,    -1},

};

/* layout(s) */
static const float      mfact           = 0.55; /* factor of master area size [0.05..0.95] */
static const int        nmaster         = 1;    /* number of clients in master area */
static const int        resizehints     = 1;    /* 1 means respect size hints in tiled resizals */
static const int        lockfullscreen  = 1;    /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol       arrange function */
    {"",           tile}, /* first entry is default */
    {"",           NULL}, /* no layout function means floating behavior */
    {"",           monocle},
    {"󰘸",           deck},

};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                       \
    {MODKEY,                            KEY,    view,       {.ui = 1 << TAG}},  \
    {MODKEY | ControlMask,              KEY,    toggleview, {.ui = 1 << TAG}},  \
    {MODKEY | ShiftMask,                KEY,    tag,        {.ui = 1 << TAG}},  \
    {MODKEY | ControlMask | ShiftMask,  KEY,    toggletag,  {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char         dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char   *dmenucmd[] = 
{ 
    "dmenu_run", "-m",  dmenumon, "-fn", dmenufont, "-nb", col_bg, "-nf", col_fg2,   "-sb", col_high, "-sf", col_bg, "-i",  NULL
}; 

static const char *termcmd[]        = {"kitty", NULL};
static const char *media_toggle[]   = {"playerctl", "--player=spotify", "play-pause", NULL};
static const char *media_next[]     = {"playerctl", "next", NULL};
static const char *media_prev[]     = {"playerctl", "previous", NULL};
static const char *lower_volume[]   = {"amixer", "-c",  "1", "sset", "PCM",    "2%-", NULL};
static const char *raise_volume[]   = {"amixer", "-c",  "1", "sset", "PCM",    "2%+", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */
    {MODKEY,                        XK_g,       spawn,          {.v = dmenucmd}},
    {MODKEY,                        XK_Return,  spawn,          {.v = termcmd}},
    {MODKEY,                        XK_b,       togglebar,      {0}},
    {MODKEY,                        XK_j,       focusstack,     {.i = +1}},
    {MODKEY,                        XK_k,       focusstack,     {.i = -1}},
    {MODKEY,                        XK_o,       incnmaster,     {.i = +1}},
    {MODKEY,                        XK_p,       incnmaster,     {.i = -1}},
    {MODKEY,                        XK_h,       setmfact,       {.f = -0.05}},
    {MODKEY,                        XK_l,       setmfact,       {.f = +0.05}},
    {MODKEY | ShiftMask,            XK_Return,  zoom,           {0}},
    {MODKEY,                        XK_Tab,     view,           {0}},
    {MODKEY,                        XK_x,       killclient,     {0}},
    {MODKEY,                        XK_t,       setlayout,      {.v = &layouts[0]}},
    {MODKEY | ShiftMask,            XK_b,       setlayout,      {.v = &layouts[1]}},
    {MODKEY,                        XK_m,       setlayout,      {.v = &layouts[2]}},
    {MODKEY,                        XK_r,       setlayout,      {.v = &layouts[3]}},
    {MODKEY | ShiftMask,            XK_space,   setlayout,      {0}},
    {MODKEY | ControlMask,          XK_space,   togglefloating, {0}},
    {MODKEY,                        XK_0,       view,           {.ui = ~0}},
    {MODKEY | ShiftMask,            XK_0,       tag,            {.ui = ~0}},
    TAGKEYS(XK_a, 0) 
    TAGKEYS(XK_s, 1) 
    TAGKEYS(XK_d, 2) 
    TAGKEYS(XK_f, 3)
    TAGKEYS(XK_q, 4) 
    TAGKEYS(XK_w, 5) 
    TAGKEYS(XK_e, 6) 
    TAGKEYS(XK_5, 7)
    TAGKEYS(XK_6, 8)

    /* custom key */
    /* { 0, XF86XK_AudioPlay,          spawn,      {.v = media_toggle } }, */
    /* { 0, XF86XK_AudioLowerVolume,   spawn,      {.v = lower_volume } }, */
    /* { 0, XF86XK_AudioRaiseVolume,   spawn,      {.v = raise_volume } }, */
    /* { 0, XF86XK_AudioNext,          spawn,      {.v = media_next } }, */
    /* { 0, XF86XK_AudioPrev,          spawn,      {.v = media_prev } }, */

    {MODKEY,                        XK_c,       spawn,          SHCMD("~/.config/rofi/scripts/launcher_t5")},
    {MODKEY | ShiftMask,            XK_g,       spawn,          SHCMD("~/.config/rofi/scripts/launcher_t2")},
    {MODKEY,                        XK_z,       exitdwm,        {0}},
    {MODKEY,                        XK_space,   focusmaster,    {0}},
    {MODKEY,                        XK_v,       spawn,          SHCMD("greenclip print | grep . | dmenu  -fn  'JetBrainsMono Nerd "
                                                                      "Font:size=10' -nf '#495156'  -nb '#1E2326' -sb '#A7C080' -sf "
                                                                      "'#1E2326' -i -l 10 -p clipboard | xargs -r -d'\n' -I '{}' "
                                                                      "greenclip print '{}' ")},
    {MODKEY,                        XK_n,       spawn,          SHCMD("~/.dwm/script/network.sh")},

    {MODKEY,                        XK_u,       spawn,          SHCMD("setxkbmap us")},
    {MODKEY,                        XK_i,       spawn,          SHCMD("setxkbmap us -variant intl")},
    {MODKEY | ShiftMask,            XK_n,       spawn,          SHCMD("dmenu-bluetooth -fn  'JetBrainsMono Nerd Font:size=10' -nf '#495156' "
                                                                      " -nb '#1E2326' -sb '#A7C080' -sf '#1E2326' -l 20 -p ' '")},
    {MODKEY | ControlMask,          XK_c,       spawn,          SHCMD("kitty --class calendar sh -c 'cal -m -w; read -s -n 1 '")},
    {MODKEY | ShiftMask,            XK_m,       spawn,          SHCMD("~/programming/python/spotipy/dmenu_spotify_playlist.sh")},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function        argument */
    {ClkLtSymbol,           0,              Button1,        setlayout,      {0}},
    {ClkLtSymbol,           0,              Button3,        setlayout,      {.v = &layouts[2]}},
    {ClkStatusText,         0,              Button2,        spawn,          {.v = termcmd}},
    {ClkClientWin,          MODKEY,         Button1,        movemouse,      {0}},
    {ClkClientWin,          MODKEY,         Button2,        togglefloating, {0}},
    {ClkClientWin,          MODKEY,         Button3,        resizemouse,    {0}},
    {ClkTagBar,             0,              Button1,        view,           {0}},
    {ClkTagBar,             0,              Button3,        toggleview,     {0}},
    {ClkTagBar,             MODKEY,         Button1,        tag,            {0}},
    {ClkTagBar,             MODKEY,         Button3,        toggletag,      {0}},
};
