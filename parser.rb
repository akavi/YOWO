class Lexer
  Token = Struct.new(:type, :value)

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
    ";" => 'END_EXPRESSION',
    /".*?"/ => 'STRING',
    "true" => 'TRUE',
    "false" => 'FALSE',
    "if" => 'IF',
    /[a-zA-Z]*/ => 'REF',
    /[0-9]*/ => 'NUM',
  }

  def lex(string)
    tokens = []
    while !string.empty?
      string = string.slice(1..-1) while string.index(/[^\S\n]/) == 0
      TOKENS.each do |matcher, type|
        matcher = Regexp.new(Regexp.quote(matcher)) if matcher.is_a?(String)
        if string.index(matcher) == 0
          match = string.match(matcher)[0]
          token = Token.new(type, match)
          tokens << token
          string = string.slice(match.length..-1)
          break
        end
      end
    end

    tokens
  end
end

class Parser
  GRAMMAR = {
    'block' => 'root',

    'expression ender' => 'block',
    'block expression ender' => 'block',
    'END_LINE' => 'ender',
    'END_EXPRESSION' => 'ender',

    'if_block' => 'expression',
    'function' => 'expression',
    'invocation' => 'expression',
    'assignment' => 'expression',
    'variable' => 'expression',
    'literal' => 'expression',
    'OPEN_PAREN expression CLOSE_PAREN' => 'expression',
    'expression EQUALS expression' => 'expression',
    'NEGATE expression' => 'expression',

    'params OPEN_BLOCK block CLOSE_BLOCK' => 'function',
    'OPEN_PARAMS CLOSE_PARAMS' => 'params',
    'OPEN_PARAMS variable CLOSE_PARAMS' => 'params',
    'OPEN_PARAMS param_list CLOSE_PARAMS' => 'params',
    'variable SEPARATOR variable' => 'param_list',

    'expression arguments' => 'invocation',
    'OPEN_INVOKE CLOSE_INVOKE' => 'arguments',
    'OPEN_INVOKE expression CLOSE_INVOKE' => 'arguments',
    'OPEN_INVOKE expression SEPARATOR expression CLOSE_INVOKE' => 'arguments',

    'IF expression OPEN_BLOCK block CLOSE_BLOCK' => 'if_block',

    'variable ASSIGN expression' => 'assignment',

    'REF' => 'variable',
    'ROOT_SIGIL REF' => 'variable',
    'PARENT_SIGIL REF' => 'variable',
    'expression LOCAL_SIGIL REF' => 'variable',

    'NUM' => 'literal',
    'TRUE' => 'literal',
    'FALSE' => 'literal',
    'STRING' => 'literal',
  }

  def parse
  end
end

tokens = Lexer.new.lex("[]->{foo}")
puts "TOKENS: #{tokens.inspect}"
