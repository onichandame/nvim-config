FROM alpine:3.18

RUN apk update
RUN apk add neovim nodejs ripgrep git
ADD . /root/.config/nvim 
RUN nvim --headless "+Lazy! sync" +qa
