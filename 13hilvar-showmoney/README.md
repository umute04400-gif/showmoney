# 13hilvar Money Display System

A beautiful, animated money display system for REDM VORP Framework that shows player money in the top-right corner of the screen.

## Features

- **Real-time Updates**: Automatically updates when player money changes
- **Smooth Animations**: Elegant fade-in/fade-out and number counting animations
- **Responsive Design**: Works on all screen resolutions
- **VORP Integration**: Seamlessly integrates with VORP Framework
- **Custom Font**: Uses Gala Condensed Medium font for authentic feel
- **Performance Optimized**: Minimal resource usage

## Installation

1. Download this resource to your `resources` folder
2. Add the font file `GalaCondensed-Medium.woff2` to the `html/fonts/` directory
3. Add `ensure 13hilvar-showmoney` to your `server.cfg`
4. Restart your server

## Font Setup

To get the Gala Condensed Medium font:
1. Download the font from a reputable source
2. Convert to WOFF2 format using an online converter
3. Place the file as `GalaCondensed-Medium.woff2` in the `html/fonts/` folder

## Commands

- `/refreshmoney` - Manually refresh money display
- `/setmoney [playerId] [amount]` - Set player money (console only)

## Configuration

The money display automatically shows/hides based on:
- Player death status
- Menu interactions
- VORP Framework events

## Compatibility

- **REDM**: Latest version
- **VORP Framework**: All versions
- **Dependencies**: vorp_core

## Support

For support or customization requests, contact 13hilvar.

---

**Version**: 1.0.0  
**Author**: 13hilvar  
**Framework**: VORP  
**Game**: Red Dead Redemption 2