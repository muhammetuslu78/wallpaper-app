import '../model/category_view_model.dart';

String apiKey = '563492ad6f91700001000001d2cea71a9bd24afb8e11f57231d93e7e';

List<CategoriesViewModel>? getCategories() {
  List<CategoriesViewModel> categories = [];
  CategoriesViewModel categoriesViewModel1 = CategoriesViewModel(
      categoryName: 'Nature',
      imgUrl:
          'https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel1);
  CategoriesViewModel categoriesViewModel2 = CategoriesViewModel(
      categoryName: 'City',
      imgUrl:
          'https://images.pexels.com/photos/1070945/pexels-photo-1070945.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel2);
  CategoriesViewModel categoriesViewModel3 = CategoriesViewModel(
      categoryName: 'Dark',
      imgUrl:
          'https://images.pexels.com/photos/3473569/pexels-photo-3473569.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel3);
  CategoriesViewModel categoriesViewModel4 = CategoriesViewModel(
      categoryName: 'Flowers',
      imgUrl:
          'https://images.pexels.com/photos/7291997/pexels-photo-7291997.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel4);
  CategoriesViewModel categoriesViewModel5 = CategoriesViewModel(
      categoryName: 'Art',
      imgUrl:
          'https://images.pexels.com/photos/161154/stained-glass-spiral-circle-pattern-161154.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel5);
  CategoriesViewModel categoriesViewModel6 = CategoriesViewModel(
      categoryName: 'Music',
      imgUrl:
          'https://images.pexels.com/photos/144429/pexels-photo-144429.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel6);
  CategoriesViewModel categoriesViewModel7 = CategoriesViewModel(
      categoryName: 'Summer',
      imgUrl:
          'https://images.pexels.com/photos/386025/pexels-photo-386025.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel7);
  CategoriesViewModel categoriesViewModel8 = CategoriesViewModel(
      categoryName: 'Food',
      imgUrl:
          'https://images.pexels.com/photos/1095550/pexels-photo-1095550.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=83&w=140');
  categories.add(categoriesViewModel8);

  return categories;
}
