tony = Skater.create(username: "shade", password: "1234", location: "Socal, LA")

Post.create(trick_to_learn: "Ramp Grind", description: "Flat Grind on half ramp", skater_id: tony.id)