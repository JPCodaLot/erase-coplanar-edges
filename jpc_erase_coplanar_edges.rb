# ---------------------------------------------------------------------------------------------------
# Erase Coplanar Edges by JPCodaLot
# 
# Copyright ©2022 JPCodaLot, All Rights Reserved
# 
# Disclaimer:
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
# WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
# ---------------------------------------------------------------------------------------------------

module JPC_Extensions
  module JPC_EraseCoplanarEdges
    unless file_loaded?(__FILE__)

    version = '1.0.0'
    ui_name = 'Erase Coplanar Edges'
    short_description = 'Deletes meaningless face disection lines.'
    long_description  = 'This extension goes hand-in-hand with the Soften Edges Panel. It completely removes taxing bisection lines leaving clean, meaningful faces.'
    extension_manager_description = 'This extension goes hand-in-hand with the Soften Edges Panel. It completely removes taxing bisection lines leaving clean, meaningful faces.'
      
    #--------------------( EDIT ABOVE )--------------------#
    
    require 'sketchup.rb'
    require 'extensions.rb'
    
    # Register the extension on startup.
    extension = SketchupExtension.new(ui_name, 'jpc_erase_coplanar_edges\main')
    extension.creator = 'JPCodalot'
    extension.version = version
    extension.copyright = '©' + Time.now.year.to_s
    extension.description = extension_manager_description
    Sketchup.register_extension(extension, true)
    
    # Create the menu command.
    command = UI::Command.new(ui_name) { JPC_EraseCoplanarEdges::erase }
    command.menu_text = ui_name
    command.tooltip = short_description
    command.status_bar_text = short_description
    command.small_icon = 'jpc_erase_coplanar_edges\toolbar_icon.jpg'
    command.large_icon = 'jpc_erase_coplanar_edges\toolbar_icon.jpg'

    # Add menu command to the context menu to if the selection contains edges.
    UI.add_context_menu_handler do |context_menu|
      unless Sketchup.active_model.selection.grep(Sketchup::Edge).to_a.empty?
        context_menu.add_item command
      end
    end
    
    # Create a toolbar and add the menu item to it.
    toolbar = UI::Toolbar.new ui_name
    toolbar = toolbar.add_item command
    toolbar.show

    end
  end
end

file_loaded(__FILE__)
