class Lexer
  TOKENS = {
    ']->' => 'CLOSE_PARAMS',
    ']' => 'CLOSE_INVOKE',
    '[' => 'OPEN_PARAMS_OR_INVOKE',
    '==' => 'EQUALS',
    '!' => 'NEGATE',
    '=' => 'ASSIGN',
    '.' => 'LOCAL_SIGIL',
    '&' => 'ROOT_SIGIL',
    '@' => 'PARENT_SIGIL',
    '{' => 'OPEN_BLOCK',
    '}' => 'CLOSE_BLOCK',
    '(' => 'OPEN_PAREN',
    ')' => 'CLOSE_PAREN',
    ',' => 'SEPARATOR',
    "\n" => 'END_LINE',
    /".*?"/ => 'STRING',
    "true" => 'TRUE',
    "false" => 'FALSE',
    "if" => 'IF',
    /[a-zA-Z]/ => 'REF',
    /[0-9]/ => 'NUM',
  }
end

class Parser
  GRAMMAR = {
    'block' => 'root'

    'expression END_LINE' => 'block'
    'block expression END_LINE' => 'block'

    'if_block' => 'expression'
    'function' => 'expression'
    'invocation' => 'expression'
    'assignment' => 'expression'
    'variable' => 'expression'
    'literal' => 'expression'
    'OPEN_PAREN expression CLOSE_PAREN' => 'expression'
    'expression EQUALS expression' => 'expression'
    'NEGATE expression' => 'expression'

    'params OPEN_BLOCK block CLOSE_BLOCK' => 'function'
    'OPEN_PARAMS CLOSE_PARAMS' => 'params'
    'OPEN_PARAMS variable CLOSE_PARAMS' => 'params'
    'OPEN_PARAMS param_list CLOSE_PARAMS' => 'params'
    'variable SEPARATOR variable' => 'param_list'

    'expression arguments' => 'invocation'
    'OPEN_INVOKE CLOSE_INVOKE' => 'arguments'
    'OPEN_INVOKE expression CLOSE_INVOKE' => 'arguments'
    'OPEN_INVOKE expression SEPARATOR expression CLOSE_INVOKE' => 'arguments'

    'IF expression OPEN_BLOCK block CLOSE_BLOCK' => 'if_block'

    'variable ASSIGN expression' => 'assignment'

    'REF' => 'variable'
    'ROOT_SIGIL REF' => 'variable'
    'PARENT_SIGIL REF' => 'variable'
    'expression LOCAL_SIGIL REF' => 'variable'

    'NUM' => 'literal'
    'TRUE' => 'literal'
    'FALSE' => 'literal'
    'STRING' => 'literal'
  }
end

class Runner
end
