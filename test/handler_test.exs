defmodule HandlerTest do
  use ExUnit.Case

  import Webserver.Handler, only: [handle: 1]

  test "GET /finance" do
    request = """
    GET /finance HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 51\r
           \r
           Personal finance, Public finance, Corporate finance
           """
  end

  test "GET /templates" do
    request = """
    GET /templates HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 495\r
    \r
    <h1>All the Templates!</h1>

    <ul>
      <li>Budgeting - personal_finance</li>
      <li>Cryptocurrency - digital finance</li>
      <li>Financial statements - corporate finance</li>
      <li>Life cycle hypothesis - personal_finance</li>
      <li>Loans and savings - banking</li>
      <li>Lottery - gambling</li>
      <li>Mpesa - personal_finance</li>
      <li>Royalties - passive income</li>
      <li>Taxes and expenditure - Public finance</li>
      <li>Valuation - Corporate finance</li>
    </ul>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /crypto" do
    request = """
    GET /crypto HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 404 Not Found\r
           Content-Type: text/html\r
           Content-Length: 32\r
           \r
           No /crypto here for GET request!
           """
  end

  test "GET /templates/1" do
    request = """
    GET /templates/1 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 81\r
    \r
    <h1>Show Template</h1>
    <p>
    Is Budgeting displaying? <strong>true</strong>
    </p>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /math" do
    request = """
    GET /math HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 51\r
           \r
           Personal finance, Public finance, Corporate finance
           """
  end

  test "GET /about" do
    request = """
    GET /about HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 1170\r
    \r
    <h1>Financial Economics Doctors</h1>

    <blockquote>
      "Facing daily economic challenges, individuals can find wisdom in the words of financial experts to navigate their financial journey. As Warren Buffett wisely said, 'Do not save what is left after spending; instead, spend what is left after saving.' This underscores the importance of prioritizing savings to build a secure financial foundation. Moreover, Benjamin Franklin's advice, 'An investment in knowledge pays the best interest,' emphasizes the value of continuous learning and acquiring financial literacy. In dealing with debts, Suze Orman's quote, 'Overspending is a habit, and so is not.' reminds us that responsible budgeting and curbing unnecessary expenses are essential to manage debts effectively. Lastly, John D. Rockefeller's insight, 'Do you know the only thing that gives me pleasure? It's to see my dividends coming in,' highlights the significance of long-term investments and the potential benefits of compound interest. By embracing these financial perspectives, individuals can overcome daily economic challenges and lay the groundwork for a more secure and prosperous future."
    </blockquote>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "POST /templates" do
    request = """
    POST /templates HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    Content-Type: application/x-www-form-urlencoded\r
    Content-Length: 21\r
    \r
    name=Risk&category=Finance
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 201 Created\r
           Content-Type: text/html\r
           Content-Length: 37\r
           \r
           Created a Finance template named Risk
           """
  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end
