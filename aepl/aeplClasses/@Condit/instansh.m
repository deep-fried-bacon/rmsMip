function instansh(obj)
    obj.wells = Well.empty(0);
    for i = 1:length(obj.wellNames)
        obj.wells(i) = Well(wellName(i),obj);
        obj.wells(i).instansh();
    end
    
        

end