# curl
Minimal behaviour by default
- Basic set of headers
- No fancy functionality
- let users enable more when wanted
- toggle features on/off one-by-one

## Long and short options
All short options have a long alternative
-s can also be set with --silent
Many options only exist as long options

## plain curl HTTP GET
```bash
curl example.com
```
you get the response body
## GET and show me the response headers
```bash
curl -i https://example.com/
```
This will get the headers included in the output
And also the body
## formated in JSON nicely using  jq
```bash
curl https://example.com/json | jq
```
## HEAD only shows the response headers
```bash
curl -I https://example.com
```
> NOTE THE USE OF CAPITAL I

## curl doesn't follow redirects by default
```bash
curl -I https://example.com/redirected
```
to follow redirects you have to tell curl to do it by adding -L
```bash
curl -I -L https://example.com/redirected
```
if there are many redirects it will stop since curl has loop dection.

## URL Globbing
Allows you to specify a set of URLs using a pattern or a wildcard character.This can be useful when you want to upload or download multiple files that follow a certain naming convention or are located on a specific directory
Use brace expansion syntax {} to specify a range of values for a specific part of the URL or asterisk(*) wildcard character to match any number of characters
```bash
curl -O https://example.com/files/*.txt
```
This will download all the files with a ".txt" extension that are located in the "files" directory
## Verbose shows more from under the hood
-v or --verbose in long format
```bash
curl -v https://example.com/
```
## pass in custom HTTP headers
Use the -H Option
```bash
curl https://example.com/ -H "Magic: disc0"
```
This will not send the user agent
```bash
curl https://example.com/ -H "User-agent:"
```
This will make the user agent field to be empty by adding ;
```bash
curl https://example.com/ -H "User-agent;"
```
## POST some basic data to the remote
use -d option
```bash
curl -d name=Brian -i https://example.com/receiver
```
## POST a file
using the @ symbol @file here file is the name of the file
-o option specifies the name of the output file to which the response from the server will be written thus the respose will be saved in a file called saved in the current working direcory
```bash
curl -d @file https://example.com/receiver -o saved
```
you can also post from standard i/o
```bash
ls -l | curl -d @- https://example.com/receiver - saved
```
you  can also use the --data-binary option to send binary data in post don't ignore the new lines or anything and send it as it is.
```bash
ls -l | curl -d @- https://example.com/receiver - saved
```
You can also add headers
```bash
curl --data-binary @file.json -H "Content-Type: application/json" https://example.com
```
## PUT a file
 


