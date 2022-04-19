module JPC_Extensions
module JPC_EraseCoplanarEdges
def JPC_EraseCoplanarEdges::erase

  # Set up
  model = Sketchup.active_model # Open model
  entities = model.entities # All entities in model
  selection = model.selection # Current selection

  # Same Plane method
  def JPC_EraseCoplanarEdges::same_plane?(faces) # Input a array of faces
    coplanar_faces = true # Set initaly to true
    if faces.length > 1 # Return false if less than one face
      plane = faces[0].plane # Plane from first face
      faces.each do |face| # Loop through ALL faces
        vertices = face.vertices # Preset vertices
        unless vertices[0].position.to_a.on_plane?(plane) and vertices[1].position.to_a.on_plane?(plane) and vertices[2].position.to_a.on_plane?(plane)
          coplanar_faces = false # Idenify not coplanar
          break # No need to check the rest
        end
      end
    else
      coplanar_faces = false # Idenify not coplanar
    end
    return coplanar_faces # Return result
  end

  # Exucute operation
  model.start_operation("Erase Coplanar Edges", true) # disable_ui: true
  edges = selection.grep(Sketchup::Edge) # All edges in model
  selection.clear # Clear the selection
  edges.each do |edge| # For every edge
    faces = edge.faces # Find the faces
    if JPC_EraseCoplanarEdges::same_plane?(faces) then selection.add edge end # Add coplanar edge to selection?
  end
  entities.erase_entities selection # Erase the coplanar edges in the selection
  model.commit_operation # Commit operation Erase Coplanar Edges

end
end
end
