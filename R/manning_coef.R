n_natural <- list(
  "Major streams" = list("Irregular, rough" = c(0.035, 0.07, 0.1)),
  "Flood plains" = list(
    "Pasture, no brush, short grass" = c(0.025, 0.03, 0.035),
    "Pasture, no brush, high grass" = c(0.03, 0.035, 0.05),
    "Cultivated areas, no crop" = c(0.02, 0.03, 0.04),
    "Cultivated areas, mature row crops" = c(0.025, 0.035, 0.045),
    "Cultivated areas, mature field crops" = c(0.03, 0.04, 0.05),
    "Brush, scattered brush, heavy weeds" = c(0.035, 0.05, 0.07),
    "Brush, light brush and trees, in winter" = c(0.035, 0.05, 0.06),
    "Brush, light brush and trees, in summer" = c(0.04, 0.06, 0.08),
    "Brush, medium to dense brush, in winter" = c(0.045, 0.07, 0.11),
    "Brush, medium to dense brush, in summer" = c(0.07, 0.1, 0.16),
    "Trees, dense willows, summer, straight" = c(0.11, 0.15, 0.2),
    "Trees, cleared land with tree stumps, no sprouts" = c(0.03, 0.04, 0.05),
    "Trees, cleared land with tree stumps, heavy growth of sprouts" = c(0.05, 0.06, 0.08),
    "Trees, heavy stand of timber, a few down trees, little undergrowth, flood stage below branches" = c(0.08, 0.1, 0.12),
    "Trees, heavy stand of timber, a few down trees, little undergrowth, flood stage reaching branches" = c(0.1, 0.12, 0.16)
  ),
  "Minor streams" = list(
    "Mountain streams, no vegetation in channel, banks steep, trees and bush on the banks submerged to high stages, with gravel, cobbles and few boulders on bottom" = c(0.03, 0.04, 0.05),
    "Mountain streams, no vegetation in channel, banks steep, trees and bush on the banks submerged to high stages, with cobbles and large boulders on bottom" = c(0.04, 0.05, 0.07),
    "Plain streams, clean, straight, full stage, no rifts or deep pools" = c(0.025, 0.03, 0.033),
    "Plain streams, clean, straight, full stage, no rifts or deep pools, more stones and weeds" = c(0.03, 0.035, 0.04),
    "Clean, winding, some pools and shoals" = c(0.033, 0.04, 0.045),
    "Clean, winding, some pools and shoals, some weeds and stones" = c(0.035, 0.045, 0.05),
    "Clean, winding, some pools and shoals, some weeds and stones, lower stages, less effective slopes and sections" = c(0.04, 0.048, 0.055),
    "Clean, winding, some pools and shoals, more weeds and stones" = c(0.045, 0.05, 0.06),
    "Sluggish reaches, weedy, deep pools" = c(0.05, 0.07, 0.08),
    "Very weedy reaches, deep pools, or floodways with heavy stand of timber and underbrush" = c(0.075, 0.1, 0.15)
  )
)

n_excavated_dredged <- list(
  "Earth, straight, and uniform" = list(
    "Clean, recently completed" = c(0.016, 0.018, 0.02),
    "Clean, after weathering" = c(0.018, 0.022, 0.025),
    "Gravel, uniform section, clean" = c(0.022, 0.025, 0.03),
    "With short grass and few weeds" = c(0.022, 0.027, 0.033)
  ),
  "Earth, winding and sluggish" = list(
    "No vegetation" = c(0.023, 0.025, 0.03),
    "Grass and some weeds" = c(0.025, 0.03, 0.033),
    "Dense weeds or aquatic plants, in deep channels" = c(0.03, 0.035, 0.04),
    "Earth bottom; rubble sides" = c(0.028, 0.03, 0.035),
    "Stony bottom; weedy banks" = c(0.025, 0.035, 0.04),
    "Cobble bottom; clean sides" = c(0.03, 0.04, 0.05)
  ),
  "Dragline-excavated or dredged" = list(
    "No vegetation" = c(0.025, 0.028, 0.033),
    "Light brush on banks" = c(0.035, 0.05, 0.06)
  ),
  "Rock cuts" = list(
    "Smooth and Uniform" = c(0.025, 0.035, 0.04),
    "Jaged and Irregular" = c(0.035, 0.04, 0.05)
  ),
  "Channels not maintained, with weeds and uncut brush" = list(
    "Dense weeds, as high as the flow depth" = c(0.05, 0.08, 0.12),
    "Clean bottom, brush on sides" = c(0.04, 0.05, 0.08),
    "Clean bottom, brush on sides, highest stage of flow" = c(0.045, 0.07, 0.11),
    "Dense brush, high stage" = c(0.08, 0.1, 0.14)
  )
)

n_lined_built <- list(
  "Metal" = list(
    "Smooth steel, unpainted" = c(0.011, 0.012, 0.014),
    "Smooth steel, painted" = c(0.012, 0.013, 0.017),
    "Corrugated" = c(0.021, 0.025, 0.03)
  ),
  "Cement" = list(
    "Neat, surface" = c(0.01, 0.011, 0.013),
    "Mortar" = c(0.011, 0.013, 0.015)
  ),
  "Wood" = list(
    "Planed, untreated" = c(0.01, 0.012, 0.014),
    "Planed, creosoted" = c(0.011, 0.012, 0.015),
    "Unplaned" = c(0.011, 0.013, 0.015),
    "Plank with battens" = c(0.012, 0.015, 0.018),
    "Lined with Roofing paper" = c(0.01, 0.014, 0.017)
  ),
  "Concrete" = list(
    "Trowel finish" = c(0.011, 0.013, 0.015),
    "Float finish" = c(0.013, 0.015, 0.016),
    "Finished, with gravel on bottom" = c(0.015, 0.017, 0.02),
    "Unfinished" = c(0.014, 0.017, 0.02),
    "Gunite, good section" = c(0.016, 0.019, 0.023),
    "Gunite, wavy section" = c(0.018, 0.022, 0.025),
    "On good excavated rock" = c(0.017, 0.02, 0.02),
    "On irregular excavated rock" = c(0.022, 0.027, 0.027)
  ),
  "Concrete bottom float" = list(
    "Finished with sides of dressed stone in mortar" = c(0.015, 0.017, 0.02),
    "Finished with sides of random stone in mortar" = c(0.017, 0.02, 0.024),
    "Finished with sides of cement rubble masonry, plastered" = c(0.016, 0.02, 0.024),
    "Finished with sides of cement rubble masonry" = c(0.02, 0.025, 0.03),
    "Finished with sides of dry rubble or riprap" = c(0.02, 0.03, 0.035)
  ),
  "Gravel bottom" = list(
    "Sides of formed concrete" = c(0.017, 0.02, 0.025),
    "Sides of random stone in mortar" = c(0.02, 0.023, 0.026),
    "Sides of dry rubble or riprap" = c(0.023, 0.033, 0.036)
  ),
  "Brick" = list(
    "Glazed" = c(0.011, 0.013, 0.015),
    "In-cement mortar" = c(0.012, 0.015, 0.018)
  ),
  "Masonry" = list(
    "Cemented rubble" = c(0.017, 0.025, 0.03),
    "Dry rubble" = c(0.023, 0.032, 0.035)
  ),
  "Dressed ashlar" = list(
    "Stone paving" = c(0.013, 0.015, 0.017)
  ),
  "Asphalt" = list(
    "Smooth" = c(0.013, 0.013, 0.013),
    "Rough" = c(0.016, 0.016, 0.016)
  ),
  "Vegatal" = list(
    "Lined" = c(0.03, 0.4, 0.5)
  )
)

n_closed_conduit <- list(
  "Brass" = list(
    "Smooth" = c(0.009, 0.01, 0.013)
  ),
  "Steel" = list(
    "Lockbar and welded" = c(0.01, 0.012, 0.014),
    "Riveted and spiral" = c(0.013, 0.016, 0.017)
  ),
  "Cast Iron" = list(
    "Coated " = c(0.01, 0.013, 0.014),
    "Uncoated" = c(0.011, 0.014, 0.016)
  ),
  "Wrought Iron" = list(
    "Black " = c(0.012, 0.014, 0.015),
    "Galvanized" = c(0.013, 0.016, 0.017)
  ),
  "Corrugated metal" = list(
    "Subdrain" = c(0.017, 0.019, 0.021),
    "Storm drain" = c(0.021, 0.024, 0.03)
  ),
  "Acrylic" = list(
    "Smooth" = c(0.008, 0.009, 0.01)
  ),
  "Glass" = list(
    "Smooth" = c(0.009, 0.01, 0.013)
  ),
  "Cement" = list(
    "Neat, surface" = c(0.01, 0.011, 0.013),
    "Mortar" = c(0.011, 0.013, 0.015)
  ),
  "Concrete" = list(
    "Culvert, straight and free of debris" = c(0.01, 0.011, 0.013),
    "Culvert, some bends, connections, and debris" = c(0.011, 0.013, 0.014),
    "Finished" = c(0.011, 0.012, 0.014),
    "Sewer with manholes, inlet, straight" = c(0.013, 0.015, 0.017),
    "Unfinished, steel form" = c(0.012, 0.013, 0.014),
    "Unfinished, smooth wood form" = c(0.012, 0.014, 0.016),
    "Unfinished, rough wood form" = c(0.015, 0.017, 0.02)
  ),
  "Wood" = list(
    "Stave" = c(0.01, 0.012, 0.014),
    "Laminated, treated" = c(0.015, 0.017, 0.02)
  ),
  "Clay" = list(
    "Common drainage tile" = c(0.011, 0.013, 0.017),
    "Vitrified sewer" = c(0.011, 0.014, 0.017),
    "Vitrified sewer with manholes, inlet, etc." = c(0.013, 0.015, 0.017),
    "Vitrified Subdrain with open joint" = c(0.014, 0.016, 0.018)
  ),
  "Brickwork" = list(
    "Glazed" = c(0.011, 0.013, 0.015),
    "Lined with cement mortar" = c(0.012, 0.015, 0.017)
  ),
  "Other" = list(
    "Sanitary sewers coated with sewage slime with bends and connections" = c(0.012, 0.013, 0.016),
    "Paved invert, sewer, smooth bottom" = c(0.016, 0.019, 0.02),
    "Rubble masonry, cemented" = c(0.018, 0.025, 0.03)
  )
)

#'@export
manning_coefficient <- list(
  "Closed Conduit" = n_closed_conduit,
  "Excavated Dredged" = n_excavated_dredged,
  "Lined Built" = n_lined_built,
  "Natural" = n_natural
)
