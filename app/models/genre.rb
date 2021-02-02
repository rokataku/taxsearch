class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '所得税' },
    { id: 3, name: '源泉所得税' },
    { id: 4, name: '譲渡所得税' },
    { id: 5, name: '相続税' },
    { id: 6, name: '贈与税' },
    { id: 7, name: '法人税' },
    { id: 8, name: '消費税' },
    { id: 9, name: '財産評価' },
    { id: 10, name: '会社法' },
    { id: 11, name: '金融商品取引法' },
    { id: 12, name: '民法' },
    { id: 13, name: '地方税' },
    { id: 14, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :posts

end