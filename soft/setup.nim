#[
# fetch all repos from user -> first 100
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  'https://api.github.com/users/daylinmorgan/repos?per_page=100' > repos.json
]#
{.define: ssl.}
import std/[
  httpclient, json,
  os, osproc,
  options, sequtils,
  strformat, strutils,
]

type
  Repo = object
    name: string
    description: string
    html_url: string

template use(client: HttpClient, body: untyped) = 
  try:
    body
  finally:
    client.close()

proc getGhRepos(): seq[Repo] =
  let
    token = getEnv("GITHUB_TOKEN")
    url = "https://api.github.com/users/daylinmorgan/repos?per_page=100"
  var
    response: string
    headers = @[
      ("Accept", "application/vnd.github+json"),
      ("X-GitHub-Api-Version", "2022-11-28")
    ]
  if token != "": headers.add ("Authorization", "Bearer " & token)
  var client = newHttpClient(headers = newHttpHeaders(headers))
  use client:
    response = client.getContent(url)
  parseJson(response).to(seq[Repo])


proc getSoftRepos(): seq[string] =
  let (output, errCode) = execCmdEx("ssh -p 23231 localhost repos list")
  if errCode != 0:
    echo "error fetching repos"
    echo "result:"
    echo output
    quit(QuitFailure)
  return output.strip().split "\n"

proc mirrorToSoft(repo: Repo, dryRun: bool) =
  var cmd = "ssh -p 23231 localhost repos import "
  cmd.add fmt"{repo.name} {repo.html_url} -m "
  if repo.description != "":
    # I've never had such problems with quotes before
    cmd.add fmt("""-d \"{quoteshell(repo.description)}\"""")
  echo cmd
  if not dryrun:
    let (output, errCode) = execCmdEx(cmd)
    if errCode != 0:
      echo "ERROR:"
      echo output

when isMainModule:
  import std/parseopt
  # const reposList = slurp("repos.txt").strip().split("\n")
  let reposList = readFile("repos.txt").strip().split('\n')
  var dryrun = false
  var p = initOptParser()
  for kind, key, val in p.getopt():
    case kind:
    of cmdEnd: break
    of cmdShortOption, cmdLongOption:
      case key:
        of "n", "--dryrun": dryrun = true
        else:
          echo "unexpected option/value -> ", key, ", ", val
    of cmdArgument:
      echo "unknown argument: ", key

  let
    ghRepos = getGhRepos()
    softRepos = getSoftRepos()

  let repos = ghRepos.filterIt(it.name in reposList)
  let toBeMirrored: seq[Repo] = repos.filterIt(it.name notin softRepos)
  if toBeMirrored.len > 0:
    for repo in toBeMirrored:
      mirrorToSoft(repo, dryrun)

