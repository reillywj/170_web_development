# The Request Response Cycle
Saturday, February 27, 2016

### Exercises

1. What are the required components of an HTTP request? What are the additional optional components?
  - Required:
    - Method (e.g. GET, POST)
    - path
  - Optional
   - Body
   - parameters
   - headers
2. What are the required components of an HTTP response? What are the additional optional components?
  - Required:
    - Status number
    - content-type
  - Optional:
    - Headers
    - Body
3. What determines whether a request should use GET or POST as its HTTP method?
  - The client does, typically by way of a link, URL, or submit button
  - GET requests are for requesting content from a server; typically a link/URL submission
  - POST requests involve sending data/info to the server to process, typically changing values stored on the server; typically use a submit button
4. Is the host component of a URL included as part of an HTTP response?
   - It's used to connect to the server but is otherwise not part of the main response