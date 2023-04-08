# git_c is a short for git_custom
function git_c
	switch $argv[1]
		case "tags"
			# delete local tags that no on remote
			git tag -l | xargs git tag -d && git fetch -t

		case "branches"
			# delete local branches with no remote
			git branch --list | grep -v "master" >/tmp/merged-branches && nvim /tmp/merged-branches && xargs git branch -D </tmp/merged-branches

		case "*"
			echo "Usage: git_c branches|tags"
	end
end
