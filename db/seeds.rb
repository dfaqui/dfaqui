# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(
  name: 'Administrador',
  email: 'admin@dfaqui.com',
  password: 'admin123'
)

admin.add_role :admin

State.create(name: 'Distrito Federal', abbreviation: 'DF')
City.create(name: 'Asa Sul', state: State.first)
DistrictGroup.create(name: 'SQS 100', city: City.first)
District.create(name: 'SQS 102', district_group: DistrictGroup.first)
Block.create(name: 'F', district: District.first)

Segment.create(id: 1, name: 'Alimentação')
Segment.create(id: 2, name: 'Tecnologia')

Category.create(id: 1, name: 'Restaurante', segment: Segment.find(1))
Category.create(id: 2, name: 'Pizzaria', segment: Segment.find(1))
Category.create(id: 3, name: 'Automação', segment: Segment.find(2))

Speciality.create(id: 1, name: 'Comida Mineira', category: Category.find(1))
Speciality.create(id: 2, name: 'Comida Japonesa', category: Category.find(1))
Speciality.create(id: 3, name: 'Residencial', category: Category.find(3))
Speciality.create(id: 4, name: 'Comercial', category: Category.find(3))
Speciality.create(id: 5, name: 'Industrial', category: Category.find(3))
