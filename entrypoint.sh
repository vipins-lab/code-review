repository="$1"
users="$2"
echo "On repository ${repository}, reviewer = [${users}]"


echo "message=Reviewers assinged to the Pull Request" >> $GITHUB_OUTPUT