@tool # Optional; runs it in the editor
extends RichTextEffect

class_name RichTextExample
# Syntax: [example][/example]
# Text effects are added in RichTextLabel -> Markup -> Custom Effects

# Define the tag name, [example].
var bbcode = "example"

func _process_custom_fx(char_fx: CharFXTransform):
    # See also: https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html#process-custom-fx
    # This function runs for every char, shader-style

    var text_server := TextServerManager.get_primary_interface()
    
    # Get parameters or defaults. E.g. [example freq=1.0]
    var freq = char_fx.env.get("freq", 5.0)
    
    # We can change individual letters' rgba
    char_fx.color.g = 0.1 * char_fx.relative_index
    # relative_index is the integer index, length is the length of the string
    # You'll note that green hits 1.0 after the 10th character, making the text pure white
    # TODO: Is there a way to get the length of the string between bbcode tags?
    
    # Rotation. rotated is around the anchor point, rotated_local is character-local. Uses radians.
    char_fx.transform = char_fx.transform.rotated_local(PI / 6)
    
    # Position (relative to where it would normally render)
    char_fx.offset.y = 10 * sin(char_fx.elapsed_time * 2 + char_fx.relative_index)

    # Fade it in
    # Note that you'll need to change the value of the textbox to reset the elapsed_time and see the effect
    var t = (char_fx.elapsed_time * 5 - char_fx.relative_index)
    char_fx.color.a = clamp(t, 0.0, 1.0)
    
    ## To get a char's value, we need the TextServer
    #var value = text_server.font_get_char_from_glyph_index(char_fx.font, 1, char_fx.glyph_index)
    ## We can then rot1
    #char_fx.glyph_index = text_server.font_get_glyph_index(char_fx.font, 1, value+1, 0)
    # It's a bit weird, because I think it keeps the original character's kerning
    
    return true
