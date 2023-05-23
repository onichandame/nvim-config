FROM archlinux

RUN pacman -Sy --noconfirm neovim git
ADD . /root/.config/nvim 
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
