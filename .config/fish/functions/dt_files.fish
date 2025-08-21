function dt_files -w git -d "Manages dotfiles"
    git --git-dir=$HOME/.dt_files --work-tree=$HOME $argv
end

function dt_files_install -w git -d "Install dotfiles"
		if test -d $HOME/.dt_files
				echo "Dotfiles repository already exists."
				return 1
		end

		git --git-dir=$HOME/.dt_files --work-tree=$HOME config --local status.showUntrackedFiles no
		echo "Dotfiles repository initialized."
end
