#!/bin/sh -l

organization="$1"
repository="$2"
users="$3"
reviewers_json="{\"reviewers\":[\"${users}\"]}"
echo $reviewers_json
echo "On  repository https://github.com/${organization}/${repository}, reviewer = [${users}]"

api_url="https://api.github.com"

# Author: vipinkrajput
# List Pulls
# URL: https://api.github.com/repos/vipins-lab/workflows/pulls
# Request Reviewers: https://api.github.com/repos/vipins-lab/workflows/pulls/${pull_number}/requested_reviewers

pulls=$(curl -sSl --request GET ${api_url}/repos/${organization}/${repository}/pulls -H "Authorization: Bearer $GITHUB_TOKEN")
echo "================================================================================="
echo "+ Author: vipinkrajput"
echo $pulls | jq -c '.[]' | while read pull; do
    pr_url=$(echo "$pull" | jq .url | tr -d '"')
    pull_number=$(echo "$pull" | jq .number | tr -d '"')
    echo "+"
    echo "| URL=$pr_url AND Pull Number=$pull_number "
    echo "+"
    assign_reviewers=$(curl -sSL -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    ${api_url}/repos/${organization}/${repository}/pulls/${pull_number}/requested_reviewers \
    -d "${reviewers_json}")

done
echo "================================================================================="
echo "message=Reviewers assinged to the Pull Requests." >> $GITHUB_OUTPUT
