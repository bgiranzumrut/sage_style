

Category.create!([
  { name: "Dresses" },
  { name: "Tops" },
  { name: "Bottoms" },
  { name: "Accessories" },
  { name: "Seasonal Collection" }
])



Product.create!([
  {
    name: "Sage Linen Dress",
    description: "Eco-conscious dress made from 100% linen in a soft sage green hue.",
    price: 79.99,
    stock_quantity: 12,
    category: Category.find_by(name: "Dresses"),
    image_url: "https://images.pexels.com/photos/5886041/pexels-photo-5886041.jpeg"
  },
  {
    name: "Cream Oversized Tee",
    description: "Relaxed-fit T-shirt in cream, made from organic cotton.",
    price: 34.99,
    stock_quantity: 25,
    category: Category.find_by(name: "Tops"),
    image_url: "https://images.pexels.com/photos/9773901/pexels-photo-9773901.jpeg"
  },
  {
    name: "Linen Wide-Leg Pants",
    description: "Minimalist beige pants with a flowy silhouette and adjustable waist.",
    price: 64.99,
    stock_quantity: 18,
    category: Category.find_by(name: "Bottoms"),
    image_url: "https://images.pexels.com/photos/5886040/pexels-photo-5886040.jpeg"
  },
  {
    name: "Gold Minimalist Necklace",
    description: "Delicate gold necklace for a simple, modern touch.",
    price: 29.99,
    stock_quantity: 30,
    category: Category.find_by(name: "Accessories"),
    image_url: "https://images.pexels.com/photos/11915399/pexels-photo-11915399.jpeg"
  },
  {
    name: "Sustainable Cotton Wrap Dress",
    description: "Flattering sage wrap dress crafted with care for the environment.",
    price: 89.00,
    stock_quantity: 10,
    category: Category.find_by(name: "Dresses"),
    image_url: "https://images.pexels.com/photos/9963290/pexels-photo-9963290.jpeg"
  },
  {
    name: "Recycled Knit Beanie",
    description: "Cozy ribbed beanie made from recycled materials in light cream.",
    price: 19.99,
    stock_quantity: 40,
    category: Category.find_by(name: "Accessories"),
    image_url: "https://images.pexels.com/photos/8442972/pexels-photo-8442972.jpeg"
  },
  {
    name: "Breezy Linen Shorts",
    description: "Lightweight sage green shorts with deep pockets and a soft waistline.",
    price: 44.00,
    stock_quantity: 22,
    category: Category.find_by(name: "Bottoms"),
    image_url: "https://images.pexels.com/photos/5886063/pexels-photo-5886063.jpeg"
  },
  {
    name: "Cotton Tank Top",
    description: "Classic cream tank top for layering or wearing solo.",
    price: 24.50,
    stock_quantity: 35,
    category: Category.find_by(name: "Tops"),
    image_url: "https://images.pexels.com/photos/5864221/pexels-photo-5864221.jpeg"
  },
  {
    name: "Sage Summer Set",
    description: "Two-piece limited edition summer set in matching sage tones.",
    price: 129.99,
    stock_quantity: 8,
    category: Category.find_by(name: "Seasonal Collection"),
    image_url: "https://images.pexels.com/photos/5886047/pexels-photo-5886047.jpeg"
  },
  {
    name: "Minimalist Crossbody Bag",
    description: "Neutral-toned canvas bag for everyday essentials.",
    price: 49.99,
    stock_quantity: 20,
    category: Category.find_by(name: "Accessories"),
    image_url: "https://images.pexels.com/photos/8428111/pexels-photo-8428111.jpeg"
  }
])


