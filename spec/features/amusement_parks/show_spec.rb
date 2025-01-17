require 'rails_helper'

RSpec.describe 'the amusement park show page' do
  describe 'as a visitor' do
    describe 'when I visit the amusement park show page' do
      it "I see the name and price of admissions for that amusement park, the names of all mechanics that are working on that park's rides, and see that the list of mechanics is unique" do
        elitch = AmusementPark.create!(name: "Elitch Gardens", admission_cost: 50)

        coaster = Ride.create!(name: 'Zoom', thrill_rating: 8, open: true, amusement_park: elitch)
        wheel = Ride.create!(name: 'Wheel of danger', thrill_rating: 6, open: false, amusement_park: elitch)
        slide = Ride.create!(name: 'Slide', thrill_rating: 4, open: true, amusement_park: elitch)

        mechanic_1 = Mechanic.create!(name: 'Matt Smith', years_experience: 2)
        ride_mech_1 = RideMechanic.create(ride: coaster, mechanic: mechanic_1)
        ride_mech_2 = RideMechanic.create(ride: wheel, mechanic: mechanic_1)

        mechanic_2 = Mechanic.create!(name: 'Stephanie Smith', years_experience: 3)
        ride_mech_3 = RideMechanic.create(ride: coaster, mechanic: mechanic_2)
        ride_mech_4 = RideMechanic.create(ride: wheel, mechanic: mechanic_2)
        ride_mech_5 = RideMechanic.create(ride: slide, mechanic: mechanic_2)

        mechanic_3 = Mechanic.create!(name: 'Sunita Smith', years_experience: 20)

        visit "/amusement_parks/#{elitch.id}"

        expect(page).to have_content("Name: #{elitch.name}")
        expect(page).to have_content("Price: #{elitch.admission_cost}")
        expect(page).to have_content("#{mechanic_1.name}")
        expect(page).to have_content("#{mechanic_2.name}")
        expect(page).to_not have_content("#{mechanic_3.name}")
      end

        it "Then I see a list of all of the park's rides, and next to the ride name I see the average experience of the mechanics working on the ride, and I see the list of rides is ordered by the average experience of mechanics working on the ride." do
        elitch = AmusementPark.create!(name: "Elitch Gardens", admission_cost: 50)

        coaster = Ride.create!(name: 'Zoom', thrill_rating: 8, open: true, amusement_park: elitch)
        wheel = Ride.create!(name: 'Wheel of danger', thrill_rating: 6, open: false, amusement_park: elitch)
        slide = Ride.create!(name: 'Slide', thrill_rating: 4, open: true, amusement_park: elitch)

        mechanic_1 = Mechanic.create!(name: 'Matt Smith', years_experience: 2)
        ride_mech_1 = RideMechanic.create(ride: coaster, mechanic: mechanic_1)
        ride_mech_2 = RideMechanic.create(ride: wheel, mechanic: mechanic_1)

        mechanic_2 = Mechanic.create!(name: 'Stephanie Smith', years_experience: 3)
        ride_mech_3 = RideMechanic.create(ride: coaster, mechanic: mechanic_2)
        ride_mech_4 = RideMechanic.create(ride: wheel, mechanic: mechanic_2)
        ride_mech_5 = RideMechanic.create(ride: slide, mechanic: mechanic_2)

        mechanic_3 = Mechanic.create!(name: 'Sunita Smith', years_experience: 20)
        ride_mech_4 = RideMechanic.create(ride: wheel, mechanic: mechanic_3)
        ride_mech_5 = RideMechanic.create(ride: slide, mechanic: mechanic_3)

        visit "/amusement_parks/#{elitch.id}"

        expect(page).to have_content("Ride Name: Zoom, Avg mechanic Experience: 2.5")
        expect(page).to have_content("Wheel of danger, Avg mechanic Experience: 8.33")
        expect(page).to have_content("Ride Name: Slide, Avg mechanic Experience: 11.5")
        expect("Zoom").to appear_before("Wheel of danger")
        expect("Wheel of danger").to appear_before("Slide")
      end
    end
  end
end