
baremodule CityKind
   const Small = 0
   const Medium = 1
   const Large = 2
end

baremodule AreaKind
   const Open = 0
   const SubUrban =  1
   const Urban = 2
end

baremodule TerrainKind
  const A = 0  # hilly terrain with moderate-to-heavy tree densities
  const B = 1  # hilly environment but rare vegetation, or high vegetation but flat terrain
  const C = 2  # mostly flat terrain with light tree densities
end

baremodule LeeArea
  const FreeSpace = (2.0,45.0)
  const OpenArea = (4.35,49.0)
  const SubUrban= (3.84,61.7)
  const Philadelphia = (3.68, 70.0)
  const Newark = (4.31, 64.0)
  const Tokyo = (3.05, 84.0)
  const NewYorkCity = (4.8,77.0)
end
