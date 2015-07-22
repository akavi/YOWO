class Lexer
  TOKENS = {
    ']->' => 'CLOSE_PARAMS',
    ']' => 'CLOSE_INVOKE',
    '[' => 'OPEN_PARAMS_OR_INVOKE',
    '==' => 'EQUALS',
    '&&' => 'AND',
    '||' => 'OR',
    '!' => 'NEGATE',
    '&=' => 'REASSIGN',
    '=' => 'ASSIGN',
    ':' => 'OBJ_SIGIL',
    '_' => 'LEX_SIGIL',
    '$' => 'DYN_SIGIL',
    '#' => 'MOD_SIGIL',
    '{' => 'OPEN_BLOCK',
    '}' => 'CLOSE_BLOCK',
    '~' => 'INVOKE',
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
    'block expression END_LINE' => 'block'
    'params OPEN_BLOCK block CLOSE_BLOCK' => 'function'
    'OPEN_PARAMS CLOSE_PARAMS' => 'params'
    'OPEN_PARAMS lhs CLOSE_PARAMS' => 'params'
    'OPEN_PARAMS param_list CLOSE_PARAMS' => 'params'
    'lhs SEPARATOR lhs' => 'param_list'
    'expression END_LINE' => 'block'
    'expression obj_var arguments' => 'expression'
    'OPEN_INVOKE CLOSE_INVOKE' => 'arguments'
    'OPEN_INVOKE expression CLOSE_INVOKE' => 'arguments'
    'OPEN_INVOKE expression SEPARATOR expression CLOSE_INVOKE' => 'arguments'
    'expression obj_var' => 'expression'
    'NUM' => 'expression'
    'TRUE' => 'expression'
    'FALSE' => 'expression'
    'STRING' => 'expression'
    'lhs' => 'expression'
    'assignment' => 'expression'
    'reassignment' => 'expression'
    'if_block' => 'expression'
    'IF expression OPEN_BLOCK block CLOSE_BLOCK' => 'if_block'
    'OBJ_SIGIL REF' => 'obj_var'
    'LEX_SIGIL REF' => 'lex_var'
    'DYN_SIGIL REF' => 'dyn_var'
    'MOD_SIGIL REF' => 'mod_var'
    'obj_var' => 'lhs'
    'lex_var' => 'lhs'
    'dyn_var' => 'lhs'
    'mod_var' => 'lhs'
    'lhs ASSIGN expression' => 'assignment'
    'lhs REASSIGN expression' => 'reassignment'
  }
end

class Runner
end
