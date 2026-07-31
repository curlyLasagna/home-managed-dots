# Aerospace

Turn MacOS into a Linux experience that I've always wanted

## Personal Opinion on Window Management

I initially embared the intended way of managing windows in MacOS through floating since the majority of programs in MacOS do not tile very well. 

I heard the Primagen's philosophy of window management and it just made sense, so I adopted the single window per workspace idea.

At most, I'll have 2 programs tiled if I really, **really** need to. Having multiple programs tiled in one workspace is too overwhelming for me.

## Looks

### Default Layout

`accordion` allows me to have a single window per workspace

Setting `accordion-padding` to 0 removes that gap that aerospaces allocates to indicate an accordion

```
accordion-padding = 0
default-root-container-layout = 'accordion'
default-root-container-orientation = 'horizontal'
```

### Gaps (Or a lack thereof)

I need all the screen real estate I can get

```
[gaps]
inner.horizontal = 0
inner.vertical =   0
outer.left =       0
outer.bottom =     0
outer.top =        0
outer.right =      0
```


## Multi-displays

### Workspace locations 

2 displays at most.

Assign only a single workspace for secondary displays

```
# Browser
alt-1 = 'workspace 1'
# Text Editors
alt-2 = 'workspace 2'
... 
```

## Movement

### Focus 

Changing focus to the other display

```
alt-leftSquareBracket = 'focus-monitor --wrap-around prev'
alt-rightSquareBracket = 'focus-monitor --wrap-around next'
```

Changing workspace focus

```
alt-tab = 'workspace next --wrap-around'
alt-shift-tab = 'workspace prev --wrap-around'
```

### Moving nodes/workspaces

Entire workspaces and their windows migrate over to the other display
```
alt-cmd-comma = 'move-workspace-to-monitor --wrap-around prev'
alt-cmd-period = 'move-workspace-to-monitor --wrap-around next'
```


Just windows themselves
```
alt-shift-leftSquareBracket = 'move-node-to-monitor --wrap-around --focus-follows-window prev'
alt-shift-rightSquareBracket = 'move-node-to-monitor --wrap-around --focus-follows-window next'
```
