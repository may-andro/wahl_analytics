abstract class Mapper<From, To> {
  Mapper._();

  To map(From from);
}

abstract class BiMapper<From, To> {
  BiMapper._();

  To to(From from);

  From from(To from);
}
