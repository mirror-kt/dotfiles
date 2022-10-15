function vi --wraps=vim --description 'alias vi nvim'
  nvim $argv; 
end

function vim --wraps=nvim --description 'alias vim nvim'
  nvim $args;
end
