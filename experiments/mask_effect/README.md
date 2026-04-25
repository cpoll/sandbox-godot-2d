The BackBufferCopy node copies what's currently displayed on the screen (at its point in the render cycle) 
to a buffer, which can then be accessed by shaders (e.g. SCREEN_TEXTURE).

BackBuffer offers it to the next shader(s) asking for a hint_screen_texture.

AFAIK, it'll keep doing that, so if you need to stop using the buffer you need to create a new one.

By default the BBC will be set to Copy Mode = Rect. Rect mode masks only the rectange. Viewport mode masks the entire viewport.
Note: You set the rect using xy+wh in the BackBufferCopy properties. This sets the screenspace coords. 
Changing the transform doesn't work. Dragging the corners changes the transform (probably a bug) and won't work.
