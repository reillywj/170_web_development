# URL Components
Sunday, February 28, 2016

1. Given following URL, id the components:

  ```
  https://amazon.com/Double-Stainless-Commercial-Refrigerator/B60HON32?ie=UTF8&qid=142952676&sr=93&keywords=commercial+fridge
  ```

  1. host: amazon.com
  2. names of query params: ie, qid, sr, keywords
  3. values of query params: UTF8, 142952676, 93, 'commercial+fridge'
  4. protocol: https://
  5. path: /Double-Stainless-Commercial-Refrigerator/B60HON32
  6. port: default or port 80
2. Add port 3000 to URL in exercise
  - `http://amazon.com:3000/products/B60HON32?qid=142952676&sr=93`
3. Given this URL, find components:

  ```
  http://localhost:4567/todos/15
  ```

  1. query params: {}; empty; none
  2. protocol: http://
  3. path: /todos/15
  4. host: localhost
  5. port: 4567
4. What are two different ways to encode a space in a qery parameter?
  1. %20 - unicode value
  2. '+' - addition symbol
5. What character is used to indicate the beginning of a URL's query parameters?
  - '?'
6. What character is used between the name and value of a query parameter?
  - '='
7. What character is used between multiple query parameters?
  - '&'
