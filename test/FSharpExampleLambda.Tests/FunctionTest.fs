namespace FSharpExampleLambda.Tests


open Amazon.Lambda.APIGatewayEvents
open Xunit
open Amazon.Lambda.TestUtilities

open FSharpExampleLambda


module FunctionTest =
    [<Fact>]
    let ``Invoke ToUpper Lambda Function``() =
        // Invoke the lambda function and confirm the string was upper cased.
        let request = APIGatewayProxyRequest()
        request.Body <- "hello world"
        let lambdaFunction = Function()
        let context = TestLambdaContext()
        let upperCase = lambdaFunction.FunctionHandler request context

        Assert.Equal("HELLO WORLD", upperCase.Body)

    [<EntryPoint>]
    let main _ = 0
