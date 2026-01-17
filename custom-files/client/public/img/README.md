# Custom Images and Logos

Place your organization's branding assets in this directory.

## Required Files

### 1. Logo Files

**logo.svg** (Recommended)
- Format: SVG (Scalable Vector Graphics)
- Recommended dimensions: Designed for width ~200px, scalable
- Used: Primary logo displayed in navigation bar
- Benefits: Scales perfectly at any size, small file size

**logo.png** (Fallback)
- Format: PNG with transparent background
- Recommended dimensions: 200x50px (or maintain similar aspect ratio)
- Used: Fallback if SVG is not provided
- Tip: Use high resolution (2x) for retina displays

### 2. Favicon

**favicon.ico**
- Format: ICO (multi-resolution icon file)
- Recommended: Include 16x16, 32x32, and 48x48px sizes in one file
- Used: Browser tab icon, bookmarks
- Tool: Use https://favicon.io to generate from PNG/SVG

## Optional Files

**social-preview.jpg**
- Format: JPG or PNG
- Recommended dimensions: 1200x630px
- Used: When sharing your forms site on social media
- Shows as preview image on Twitter, Facebook, LinkedIn, etc.

## File Naming

File names are **case-sensitive**. Use exact names:
- ✅ `logo.svg`
- ✅ `logo.png`
- ✅ `favicon.ico`
- ❌ `Logo.svg`
- ❌ `LOGO.PNG`

## Design Tips

### Logo Design
1. **Keep it simple**: Should be readable at small sizes
2. **Transparent background**: PNG/SVG should have transparent background
3. **Horizontal orientation**: Works best in navigation bar
4. **Color consideration**: Should work on white backgrounds

### Favicon Design
1. **Simple icon**: Should be recognizable at 16x16px
2. **High contrast**: Should stand out in browser tabs
3. **Brand color**: Use your primary brand color

## Example Workflow

1. **Design your logo** in your favorite tool (Figma, Illustrator, etc.)

2. **Export files**:
   ```
   - logo.svg (from your design tool)
   - logo.png (2x size, transparent background)
   - icon.png (512x512px for favicon generation)
   ```

3. **Generate favicon**:
   - Go to https://favicon.io
   - Upload your icon.png
   - Download favicon.ico

4. **Place files** in this directory:
   ```
   custom-files/client/public/img/
   ├── logo.svg
   ├── logo.png
   └── favicon.ico
   ```

5. **Deploy** using the deploy.sh script

## Troubleshooting

**Logo not showing after deployment:**
- Clear browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Check file names are exact (case-sensitive)
- Verify files were copied (check `/client/public/img/` in OpnForm dir)

**Favicon not updating:**
- Favicons are heavily cached by browsers
- Try different browser or incognito mode
- Wait 5-10 minutes and hard refresh

**Logo appears pixelated:**
- Use SVG format (scales perfectly)
- If using PNG, export at 2x resolution (400x100px for 200x50px display)

## Testing Locally

After placing files here, you can test before deployment:

1. Copy files to OpnForm directory:
   ```bash
   cp logo.* /path/to/OpnForm/client/public/img/
   cp favicon.ico /path/to/OpnForm/client/public/
   ```

2. If running locally, view at `http://localhost:3000`

3. Check browser console for any 404 errors on images

## Current Files

This directory should contain your custom branding files. Currently:
- [ ] logo.svg
- [ ] logo.png
- [ ] favicon.ico
- [ ] social-preview.jpg (optional)
