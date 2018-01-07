# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Service.delete_all
Category.delete_all

agriculture = Category.create!(name: 'AGRICULTURE')
infrastructures = Category.create!(name: 'INFRASTRUCTURES')
assurance = Category.create!(name: 'ASSURANCE')
viticulture = Category.create!(name: 'VITICULTURE')
topographie = Category.create!(name: 'TOPOGRAPHIE')


Service.create!(title: 'Prestation d\'agriculture', 
  description: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer 
  took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, 
  but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s 
  with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
  software like Aldus PageMaker including versions of Lorem Ipsum.',
  price: '9.9', category_id: agriculture.id)

Service.create!(title: 'Prestation d\'infrastructures', 
  description: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer 
  took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, 
  but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s 
  with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
  software like Aldus PageMaker including versions of Lorem Ipsum.',
  price: '1999.90', category_id: infrastructures.id)

Service.create!(title: 'Prestation d\'assurance', 
  description: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer 
  took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, 
  but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s 
  with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
  software like Aldus PageMaker including versions of Lorem Ipsum.',
  price: '4999.90', category_id: assurance.id)

Service.create!(title: 'Prestation de viticulture', 
  description: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer 
  took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, 
  but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s 
  with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
  software like Aldus PageMaker including versions of Lorem Ipsum.',
  price: '699.90', category_id: viticulture.id)

Service.create!(title: 'Prestation de topographie', 
  description: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer 
  took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, 
  but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s 
  with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
  software like Aldus PageMaker including versions of Lorem Ipsum.',
  price: '250', category_id: topographie.id)
