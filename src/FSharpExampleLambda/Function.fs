namespace FSharpExampleLambda


open System.Collections.Generic
open Amazon.Lambda.APIGatewayEvents
open Amazon.Lambda.Core

open System

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[<assembly: LambdaSerializer(typeof<Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer>)>]
()

module Helpers =
    let inline (<??>) (value: 'a) (replacement: 'a) =
        match value with
        | null -> replacement
        | _ -> value

open Helpers

type Function() =
    /// <summary>
    /// A simple function that takes a string and does a ToUpper
    /// </summary>
    /// <param name="input"></param>
    /// <param name="context"></param>
    /// <returns></returns>
    member __.FunctionHandler (input: APIGatewayProxyRequest) (_: ILambdaContext) =
        let output =
            match input with
            | null -> String.Empty
            | _ -> (input.Body <??> String.Empty).ToUpper()

        let headers = Dictionary<string, string>()
        headers.Add("Content-Type", "text/plain")

        let response = APIGatewayProxyResponse()
        response.Body <- output
        response.StatusCode <- 200
        response.Headers <- headers

        response
