#!/bin/sh -l

: '
********************
Author: vipinkrajput
********************
List Pulls
URL: https://api.github.com/repos/vipins-lab/workflows/pulls
Request Reviewers: https://api.github.com/repos/vipins-lab/workflows/pulls/${pull_number}/requested_reviewers
'

repository="$1"
users="$2"
# reviewers_json="{\"reviewers\":[\"${users}\"]}"
reviewers_json=$(jq -n -c -M --arg s "$users" '{reviewers: ($s|split(","))}')
echo $reviewers_json
echo "On  repository https://github.com/${repository} reviewer = [${users}]"

api_url="https://api.github.com"

pulls=$(curl -sSl --request GET ${api_url}/repos/${repository}/pulls -H "Authorization: Bearer $GITHUB_TOKEN")
echo "+================================================================================+"
echo "| "
echo "| "
echo $pulls | jq -c '.[]' | while read pull; do
    pr_url=$(echo "$pull" | jq .url | tr -d '"')
    pull_number=$(echo "$pull" | jq .number | tr -d '"')
    echo "|"
    echo "| URL=$pr_url AND Pull Number=$pull_number "
    echo "|"
    assign_reviewers=$(curl -sSL -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    ${api_url}/repos/${repository}/pulls/${pull_number}/requested_reviewers \
    -d "${reviewers_json}")
echo "| "
echo "| "
done
echo "+================================================================================+"
echo "message=Reviewers assinged to the Pull Requests." >> $GITHUB_OUTPUT
