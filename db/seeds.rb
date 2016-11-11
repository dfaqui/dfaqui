admin = User.create(
  name: 'Administrador',
  email: 'admin@dfaqui.com',
  password: 'admin123'
)

admin.add_role :admin

State.create(name: 'Distrito Federal', abbreviation: 'DF')

City.create(id: 1, name: 'Asa Sul', state: State.first)
City.create(id: 2, name: 'Noroeste', state: State.first)

DistrictGroup.create(name: 'SQS 100', city: City.find(1))
District.create(name: 'SQS 102', district_group: DistrictGroup.first)
Block.create(name: 'F', district: District.first)

Segment.create(id: 1, name: 'Alimentação')
Segment.create(id: 2, name: 'Tecnologia')

Category.create(id: 1, name: 'Restaurante', segment: Segment.find(1))
Category.create(id: 2, name: 'Pizzaria', segment: Segment.find(1))
Category.create(id: 3, name: 'Automação', segment: Segment.find(2))
Category.create(id: 4, name: 'Hardware', segment: Segment.find(2))
Category.create(id: 5, name: 'Software', segment: Segment.find(2))

Speciality.create(id: 1, name: 'Comida Mineira', category: Category.find(1))
Speciality.create(id: 2, name: 'Comida Japonesa', category: Category.find(1))
Speciality.create(id: 3, name: 'Residencial', category: Category.find(3))
Speciality.create(id: 4, name: 'Comercial', category: Category.find(3))
Speciality.create(id: 5, name: 'Industrial', category: Category.find(3))
Speciality.create(id: 6, name: 'Arduino', category: Category.find(4))
Speciality.create(id: 7, name: 'Java', category: Category.find(5))
Speciality.create(id: 8, name: 'Ruby on Rails', category: Category.find(5))
Speciality.create(id: 9, name: 'PHP', category: Category.find(5))
Speciality.create(id: 10, name: 'Pizza Vegetariana', category: Category.find(2))

PaymentMethod.create(icon: 'cartao.png', name: 'Cartão')
PaymentMethod.create(icon: 'boleto.png', name: 'Boleto')
PaymentMethod.create(icon: 'visa.png', name: 'Visa')
PaymentMethod.create(icon: 'mastercard.png', name: 'MasterCard')
PaymentMethod.create(icon: 'dinheiro.png', name: 'Dinheiro')

Tag.create(id: 1, name: 'Piscina', plugin: 'property')
Tag.create(id: 2, name: 'Academia', plugin: 'property')
Tag.create(id: 3, name: 'Churrasqueira', plugin: 'property')
Tag.create(id: 4, name: 'Sala de Jogos', plugin: 'property')
Tag.create(id: 5, name: 'Brinquedoteca', plugin: 'property')

Page.create(
  code: 'property-banner',
  value: 'https://s3-sa-east-1.amazonaws.com/dfaqui/banner/imoveis/imoveis-asa-sul-banner.jpg',
  condition: 'asa-sul'
)

Page.create(
  code: 'property-banner',
  value: 'https://s3-sa-east-1.amazonaws.com/dfaqui/banner/imoveis/imoveis-noroeste-banner.jpg',
  condition: 'noroeste'
)
