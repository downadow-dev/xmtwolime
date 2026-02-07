#!/usr/bin/python3

from pycparser.c_ast import *


current_function = ''   # мы находимся в теле этой функции
                        # (пока лишь в глобальном пространстве имён)

variables = []          # переменные
functions = []          # функции
functions_floatparams = {}
arrays = []
floats = []
floatptrs = []
floatptrptrs = []
unss = []
unsptrs = []
unsptrptrs = []

funcfixed = {}

continuel = 0
current_if = 0
current_for = 0
current_while = 0
current_switchl = 0
current_continue = ''
current_break = ''

enumerators = {}
structs = {}
structures = {}
structuresnoptrs = {}
typedefs = {}

# получить переменную/массив
def get_var(name):
    if current_function == '' or not (current_function + '.' + name) in variables:
        return '{' + name + '}'
    else:
        return '{' + current_function + '.' + name + '}'

def is_array(name):
    return ((current_function != '' and (current_function + '.' + name) in arrays) or name in arrays)

def is_float(obj, ptrlvl=0):
    if type(obj) == str and ptrlvl == -2:
        return ((current_function != '' and (current_function + '.' + obj) in floatptrptrs) or obj in floatptrptrs)
    elif type(obj) == str and ptrlvl == -1:
        return ((current_function != '' and (current_function + '.' + obj) in floatptrs) or obj in floatptrs)
    elif type(obj) == str and ptrlvl == 0:
        return ((current_function != '' and (current_function + '.' + obj) in floats) or obj in floats)
    elif type(obj) == Decl:
        return is_float(obj.type, ptrlvl=ptrlvl)
    elif type(obj) == PtrDecl:
        return is_float(obj.type, ptrlvl=ptrlvl+1)
    elif type(obj) == Assignment:
        return is_float(obj.lvalue, ptrlvl=ptrlvl)
    elif type(obj) == FuncCall and type(obj.name) == ID and obj.name.name == '_call' and preprocess_string(obj.args.exprs[0].value) == 'fzip' and ptrlvl == 0:
        return True
    elif type(obj) == FuncCall:
        return is_float(obj.name, ptrlvl=ptrlvl)
    elif type(obj) == Cast:
        return is_float(obj.to_type, ptrlvl=ptrlvl)
    elif type(obj) == Typename:
        return is_float(obj.type, ptrlvl=ptrlvl)
    elif type(obj) == TypeDecl:
        return is_float(obj.type, ptrlvl=ptrlvl)
    elif type(obj) == IdentifierType and ('float' in obj.names or 'double' in obj.names) and ptrlvl == 0:
        return True
    elif type(obj) == Constant and ('float' in obj.type or 'double' in obj.type) and ptrlvl == 0:
        return True
    elif type(obj) == ID:
        return is_float(obj.name, ptrlvl=ptrlvl)
    elif type(obj) == UnaryOp and obj.op == '*':
        return is_float(obj.expr, ptrlvl=ptrlvl-1)
    elif type(obj) == UnaryOp and obj.op == '&':
        return is_float(obj.expr, ptrlvl=ptrlvl+1)
    elif type(obj) == UnaryOp:
        return is_float(obj.expr, ptrlvl=ptrlvl)
    elif type(obj) == BinaryOp and obj.op != '&&' and obj.op != '||':
        return is_float(obj.left, ptrlvl=ptrlvl) or is_float(obj.right, ptrlvl=ptrlvl)
    elif type(obj) == ArrayRef:
        return is_float(obj.name, ptrlvl=ptrlvl-1)
    elif type(obj) == TernaryOp:
        return is_float(obj.iftrue, ptrlvl=ptrlvl) or is_float(obj.iffalse, ptrlvl=ptrlvl)
    elif type(obj) == StructRef:
        struct = get_struct(obj.name)
        for decl in struct:
            if obj.field.name == decl.name:
                return is_float(decl.type)
    else:
        return False

def is_uns(obj, ptrlvl=0):
    if type(obj) == str and ptrlvl == -2:
        return ((current_function != '' and (current_function + '.' + obj) in unsptrptrs) or obj in unsptrptrs)
    elif type(obj) == str and ptrlvl == -1:
        return ((current_function != '' and (current_function + '.' + obj) in unsptrs) or obj in unsptrs)
    elif type(obj) == str and ptrlvl == 0:
        return ((current_function != '' and (current_function + '.' + obj) in unss) or obj in unss)
    elif type(obj) == Decl:
        return is_uns(obj.type, ptrlvl=ptrlvl)
    elif type(obj) == PtrDecl:
        return is_uns(obj.type, ptrlvl=ptrlvl+1)
    elif type(obj) == Assignment:
        return is_uns(obj.lvalue, ptrlvl=ptrlvl)
    elif type(obj) == FuncCall:
        return is_uns(obj.name, ptrlvl=ptrlvl)
    elif type(obj) == Cast:
        return is_uns(obj.to_type, ptrlvl=ptrlvl)
    elif type(obj) == Typename:
        return is_uns(obj.type, ptrlvl=ptrlvl)
    elif type(obj) == TypeDecl:
        return is_uns(obj.type, ptrlvl=ptrlvl)
    elif type(obj) == IdentifierType and ('unsigned' in obj.names) and ptrlvl == 0:
        return True
    elif type(obj) == Constant and ('unsigned' in obj.type) and ptrlvl == 0:
        return True
    elif type(obj) == ID:
        return is_uns(obj.name, ptrlvl=ptrlvl)
    elif type(obj) == UnaryOp and obj.op == '*':
        return is_uns(obj.expr, ptrlvl=ptrlvl-1)
    elif type(obj) == UnaryOp and obj.op == '&':
        return is_uns(obj.expr, ptrlvl=ptrlvl+1)
    elif type(obj) == UnaryOp:
        return is_uns(obj.expr, ptrlvl=ptrlvl)
    elif type(obj) == BinaryOp and obj.op != '&&' and obj.op != '||':
        return is_uns(obj.left, ptrlvl=ptrlvl) or is_uns(obj.right, ptrlvl=ptrlvl)
    elif type(obj) == ArrayRef:
        return is_uns(obj.name, ptrlvl=ptrlvl-1)
    elif type(obj) == TernaryOp:
        return is_uns(obj.iftrue, ptrlvl=ptrlvl) or is_uns(obj.iffalse, ptrlvl=ptrlvl)
    elif type(obj) == StructRef:
        struct = get_struct(obj.name)
        for decl in struct:
            if obj.field.name == decl.name:
                return is_uns(decl.type)
    else:
        return False

# создаёт переменную/массив
def create_var(name, array_len=0):
    global variables
    global arrays
    
    if current_function != '':
        name = current_function + '.' + name
    
    if not name in variables:
        variables += [name]
    if not name in arrays and array_len > 0:
        arrays += [name]
    elif name in arrays and array_len <= 0:
        for i in range(len(arrays)):
            if arrays[i] == name:
                del arrays[i]
                break
    return '/alloc ' + name + ('[' + str(array_len) + ']' if array_len > 0 else '') + '\n'

def get_struct_length(struct):
    l = 0
    for decl in struct:
        if type(decl.type) == ArrayDecl:
            l += static_int(decl.type.dim)
        elif type(decl.type) == TypeDecl and (type(decl.type.type) == Struct or type(decl.type.type) == Union):
            l += get_struct_length((structs[decl.type.type.name] if decl.type.type.name != None else decl.type.type.decls))
        else:
            l += 1
    return l

def get_struct(obj):
    struct = []
    
    obj = preprocess_typedefs(obj)
    
    if type(obj) == ID:
        return structs[structures[obj.name]].copy()
    elif type(obj) == ArrayRef:
        return get_struct(obj.name)
    elif type(obj) == UnaryOp:
        return get_struct(obj.expr)
    elif type(obj) == BinaryOp:
        return get_struct(obj.left)
    # (struct|union NAME)
    elif type(obj) == Cast and type(obj.to_type.type) == TypeDecl and (type(obj.to_type.type.type) == Struct or type(obj.to_type.type.type) == Union):
        struct = structs[obj.to_type.type.type.name].copy()
    # (struct|union NAME *)
    elif type(obj) == Cast and type(obj.to_type.type) == PtrDecl and type(obj.to_type.type.type) == TypeDecl and (type(obj.to_type.type.type.type) == Struct or type(obj.to_type.type.type.type) == Union):
        struct = structs[obj.to_type.type.type.type.name].copy()
    # StructRef
    elif type(obj) == StructRef:
        struct = get_struct(obj.name)
        for decl in struct:
            if obj.field.name == decl.name:
                decl.type = preprocess_typedefs(decl.type)
                if type(decl.type) == TypeDecl and (type(decl.type.type) == Struct or type(decl.type.type) == Union):
                    return (structs[decl.type.type.name] if decl.type.type.name != None else decl.type.type.decls).copy()
                elif type(decl.type) == PtrDecl and type(decl.type.type) == TypeDecl and (type(decl.type.type.type) == Struct or type(decl.type.type.type) == Union):
                    return (structs[decl.type.type.type.name] if decl.type.type.type.name != None else decl.type.type.type.decls).copy()
                else:
                    raise Exception('StructRef error')
                    return []
    # ?
    else:
        raise Exception('StructRef error')
        return []
    return struct

# преобразовать '\'-последовательности в строке
def preprocess_string(s):
    # пропустить префиксы вроде L
    while not s.startswith('"') and not s.startswith("'"):
        s = s[1:]
    
    return s[1:-1].replace('\\\\', '%/\\\\/%')  \
        .replace('\\"', '"')                    \
        .replace('\\\'', '\'')                  \
        .replace('\\n', '\n')                   \
        .replace('\\b', '\b')                   \
        .replace('\\r', '\r')                   \
        .replace('\\t', '\t')                   \
        .replace('\\f', '\f')                   \
        .replace('\\a', '\a')                   \
        .replace('\\v', '\v')                   \
        .replace('\\033', '\033')               \
        .replace('\\0', '\0')                   \
        .replace('%/\\\\/%', '\\')

# "2 == 4" => "2 4 =?" и т. д.
def compile_cond(op):
    global current_if
    
    if op == None:
        return '1' # true
    elif type(op) == UnaryOp and op.op == '!':
        return compile_cond(op.expr) + ' !'
    
    if type(op) == BinaryOp:
        if op.op == '==':
            return compile_obj(op.left, flt=is_float(op)) + ' ' + compile_obj(op.right, flt=is_float(op)) + ' ' + ('=?' if not is_float(op) else '@__feq')
        elif op.op == '!=':
            return compile_obj(op.left, flt=is_float(op)) + ' ' + compile_obj(op.right, flt=is_float(op)) + ' ' + ('!?' if not is_float(op) else '@__fne')
        elif op.op == '<':
            return compile_obj(op.left, flt=is_float(op)) + ' ' + compile_obj(op.right, flt=is_float(op)) + ' ' + (('lt?' if not is_uns(op) else 'ult?') if not is_float(op) else '@__flt')
        elif op.op == '>':
            return compile_obj(op.left, flt=is_float(op)) + ' ' + compile_obj(op.right, flt=is_float(op)) + ' ' + (('gt?' if not is_uns(op) else 'ugt?') if not is_float(op) else '@__fgt')
        elif op.op == '>=':
            return compile_obj(op.left, flt=is_float(op)) + ' ' + compile_obj(op.right, flt=is_float(op)) + ' ' + (('-- gt?' if not is_uns(op) else '-- ugt?') if not is_float(op) else '@__fge')
        elif op.op == '<=':
            return compile_obj(op.left, flt=is_float(op)) + ' ' + compile_obj(op.right, flt=is_float(op)) + ' ' + (('++ lt?' if not is_uns(op) else '++ ult?') if not is_float(op) else '@__fle')
        
        elif op.op == '&&':
            code = ''
            saved = current_if
            current_if += 1
            code += compile_cond(op.left) + ' dup ~___ANDend' + str(saved) + ' else drop '
            code += compile_cond(op.right) + ' ___ANDend' + str(saved) + ':'
            return code
        elif op.op == '||':
            code = ''
            saved = current_if
            current_if += 1
            code += compile_cond(op.left) + ' dup ~___ORend' + str(saved) + ' then drop '
            code += compile_cond(op.right) + ' ___ORend' + str(saved) + ':'
            return code
        
        else:
            return compile_obj(op) + ' 0 !?'
    
    else:
        return compile_obj(op) + ' 0 !?'

def static_int(obj):
    try:
        if type(obj) == UnaryOp:
            obj.expr = preprocess_typedefs(obj.expr)
        
        if type(obj) == Constant and (obj.type.startswith('unsigned') or obj.type.startswith('long')):
            obj.type = 'int'
        
        if type(obj) == Constant and obj.type == 'int':
            obj.value = obj.value.lower().replace('u', '').replace('l', '')
        
        if type(obj) == Constant and obj.type == 'int' and obj.value == '0':
            return 0
        elif type(obj) == Constant and obj.type == 'char':
            return ord(preprocess_string(obj.value))
        elif type(obj) == Constant and obj.type == 'int' and obj.value.startswith('0x'):
            return int(obj.value[2:], base=16)
        elif type(obj) == Constant and obj.type == 'int' and obj.value.startswith('0b'):
            return int(obj.value[2:], base=2)
        elif type(obj) == Constant and obj.type == 'int' and obj.value.startswith('0'):
            return int(obj.value[1:], base=8)
        elif type(obj) == Constant and obj.type == 'int':
            return int(obj.value, base=10)
        elif type(obj) == BinaryOp and obj.op == '+':
            return static_int(obj.left) + static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '-':
            return static_int(obj.left) - static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '*':
            return static_int(obj.left) * static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '/':
            return static_int(obj.left) // static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '%':
            return static_int(obj.left) % static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '^':
            return static_int(obj.left) ^ static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '<<':
            return static_int(obj.left) << static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '>>':
            return static_int(obj.left) >> static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '|':
            return static_int(obj.left) | static_int(obj.right)
        elif type(obj) == BinaryOp and obj.op == '&':
            return static_int(obj.left) & static_int(obj.right)
        elif type(obj) == UnaryOp and obj.op == 'sizeof' and type(obj.expr) == ID and is_array(obj.expr.name):
            return None
        elif type(obj) == UnaryOp and obj.op == 'sizeof' and type(obj.expr) == Typename and \
        type(obj.expr.type) == TypeDecl and (type(obj.expr.type.type) == Struct or type(obj.expr.type.type) == Union) and \
        obj.expr.type.type.name in structs:
            return get_struct_length(structs[obj.expr.type.type.name])
        elif type(obj) == UnaryOp and obj.op == 'sizeof' and type(obj.expr) == StructRef:
            for decl in structs[structures[obj.expr.name.name]]:
                if decl.name == obj.expr.field.name:
                    if type(decl.type) == ArrayDecl:
                        return static_int(decl.type.dim)
                    else:
                        return 1
            return 0
        elif type(obj) == UnaryOp and obj.op == 'sizeof' and type(obj.expr) == ID and obj.expr.name in structuresnoptrs:
            return get_struct_length(structs[structures[obj.expr.name]])
        elif type(obj) == UnaryOp and obj.op == 'sizeof' and type(obj.expr) == UnaryOp and obj.expr.op == '*' and type(obj.expr.expr) == ID and obj.expr.expr.name in structures and not obj.expr.expr.name in structuresnoptrs:
            return get_struct_length(structs[structures[obj.expr.expr.name]])
        elif type(obj) == UnaryOp and obj.op == 'sizeof' and type(obj.expr) == ArrayRef and type(obj.expr.name) == ID and obj.expr.name.name in structures and not obj.expr.name.name in structuresnoptrs:
            return get_struct_length(structs[structures[obj.expr.name.name]])
        elif type(obj) == UnaryOp and obj.op == 'sizeof':
            return 1
    except Exception: pass
    return None

def preprocess_typedefs(obj):
    if type(obj) == Decl:
        obj.type = preprocess_typedefs(obj.type)
    elif type(obj) == TypeDecl and type(obj.type) == IdentifierType and obj.type.names[0] in typedefs:
        obj = typedefs[obj.type.names[0]]
    elif (type(obj) == PtrDecl or type(obj) == ArrayDecl):
        obj.type = preprocess_typedefs(obj.type)
    elif type(obj) == Cast:
        obj.to_type.type = preprocess_typedefs(obj.to_type.type)
    elif type(obj) == Typename:
        obj.type = preprocess_typedefs(obj.type)
    
    if type(obj) == PtrDecl and type(obj.type) == PtrDecl:
        obj.type = preprocess_typedefs(obj.type.type)
    
    return obj

current_string = -1
# компиляция числа, переменной и т. д.
def compile_obj(obj, root=False, flt=False, uns=False):
    global continuel
    global current_string
    global current_function
    global variables
    global arrays
    global functions
    global functions_floatparams
    global floats
    global floatptrs
    global floatptrptrs
    global unss
    global unsptrs
    global unsptrptrs
    global current_if
    global current_while
    global current_for
    global current_switchl
    global enumerators
    global structs
    global structures
    global structuresnoptrs
    global current_continue
    global current_break
    global typedefs
    
    obj = preprocess_typedefs(obj)
    
    try:
        if type(obj) == Typedef:
            typedefs[obj.name] = preprocess_typedefs(obj.type)
            return ''
        elif obj == None or (type(obj) == Decl and 'extern' in obj.storage and type(obj.type) != FuncDecl) or (type(obj) == Constant and root):
            return ''
        elif type(obj) == DoWhile and type(obj.cond) == Constant and obj.cond.type == 'int' and obj.cond.value == '0':
            return compile_obj(obj.stmt)
        # sizeof(массив)
        elif type(obj) == UnaryOp and obj.op == 'sizeof' and type(obj.expr) == ID and is_array(obj.expr.name) and not root:
            return get_var(obj.expr.name)[:-1] + '.length}'
        #####################
        elif static_int(obj) != None and not root:
            return str(static_int(obj))
        # float
        elif not flt and not root and is_float(obj):
            return compile_obj(obj, flt=True) + ' @__f2i'
        elif type(obj) == Constant and is_float(obj):
            n = 0
            try:
                n = int(obj.value.lower().replace('f', '').split('.')[0].split('e')[0])
            except Exception: pass
            lw = 0
            
            if '.' in obj.value:
                s = obj.value.lower().replace('f', '').split('.')[1].split('e')[0]
                for i in range(len(s)):
                    n *= 10
                    lw += 1
                try:
                    n += int(s)
                except Exception: pass
            
            if 'e' in obj.value.lower():
                num = int(obj.value.lower().replace('f', '').split('e')[1])
                if num < 0:
                    lw += -num
                else:
                    while num > 0:
                        if lw > 0:
                            lw -= 1
                        else:
                            n *= 10
                        num -= 1
            
            while n >= 100000000 and lw > 0:
                n //= 10
                lw -= 1
            
            return str(n | (lw << 27))
        elif type(obj) == BinaryOp and obj.op in '+-/*' and is_float(obj):
            return compile_obj(obj.left, flt=True) + ' ' + compile_obj(obj.right, flt=True) + ' @__f' + obj.op.replace('+', 'add').replace('-', 'sub').replace('/', 'div').replace('*', 'mul')
        elif type(obj) == Assignment and obj.op == '=' and is_float(obj):
            return compile_obj(obj.lvalue, flt=True)[:-2] + ' ' + ('dup' if not root else '') + ' ' + compile_obj(obj.rvalue, flt=True) + ' swap = ' + ('.' if not root else '')
        elif type(obj) == Assignment and obj.op[0] in '+-/*' and obj.op.endswith('=') and is_float(obj):
            return compile_obj(obj.lvalue, flt=True)[:-2] + ' dup ' + ('dup' if not root else '') + ' . ' + compile_obj(obj.rvalue, flt=True) + ' @__f' + obj.op[0].replace('+', 'add').replace('-', 'sub').replace('/', 'div').replace('*', 'mul') + ' swap = ' + ('.' if not root else '')
        elif type(obj) == UnaryOp and obj.op == '++' and is_float(obj):
            return '' + compile_obj(obj.expr, flt=True)[:-2] + ' ' + ('dup ' if not root else ' ') + 'dup . 1 @__fadd swap =' + (' .' if not root else '')
        elif type(obj) == UnaryOp and obj.op == '--' and is_float(obj):
            return '' + compile_obj(obj.expr, flt=True)[:-2] + ' ' + ('dup ' if not root else ' ') + 'dup . 1 @__fsub swap =' + (' .' if not root else '')
        elif type(obj) == UnaryOp and obj.op == 'p++' and is_float(obj):
            return '' + compile_obj(obj.expr, flt=True)[:-2] + ' ' + ('dup . swap ' if not root else ' ') + 'dup . 1 @__fadd swap ='
        elif type(obj) == UnaryOp and obj.op == 'p--' and is_float(obj):
            return '' + compile_obj(obj.expr, flt=True)[:-2] + ' ' + ('dup . swap ' if not root else ' ') + 'dup . 1 @__fsub swap ='
        ########################
        elif type(obj) == Compound:
            code = ''
            if obj.block_items != None:
                for item in obj.block_items:
                    code += compile_obj(item, root=True) + '\n'
            return code
        elif type(obj) == NamedInitializer:
            return compile_obj(obj.expr)
        elif type(obj) == ExprList:
            code = ''
            for item in obj.exprs[:-1]:
                code += compile_obj(item, root=True) + '\n'
            code += compile_obj(obj.exprs[-1], root=root)
            return code
        elif type(obj) == ID and obj.name == '__func__':
            current_string += 1
            return '\n"' + current_function + '" ___s' + str(current_string) + '\n&___s' + str(current_string)
        # новая функция
        elif type(obj) == FuncDef:
            code = ''
            
            savedvariables = variables.copy()
            savedarrays = arrays.copy()
            savedstructures = structures.copy()
            savedstructuresnoptrs = structuresnoptrs.copy()
            savedenumerators = enumerators.copy()
            savedtypedefs = typedefs.copy()
            savedfloats = floats.copy()
            savedfloatptrs = floatptrs.copy()
            savedfloatptrptrs = floatptrptrs.copy()
            savedunss = unss.copy()
            savedunsptrs = unsptrs.copy()
            savedunsptrptrs = unsptrptrs.copy()
            
            # вложенные функции не поддерживаются
            if current_function != '':
                raise Exception('create function: current_function != \'\'')
            #####################################
            elif obj.decl.name == 'main':
                code += 'main:\n'
                current_function = 'main'
                
                if obj.decl.type.args != None and len(obj.decl.type.args.params) > 1:
                    if not '__get_args' in functions:
                        print('*** ERROR while compiling main(): please give "-include include/__get_args.h"', file=sys.stderr)
                        return ''
                    
                    code += '/alloc ' + obj.decl.type.args.params[0].name + '\n'
                    code += '/alloc ' + obj.decl.type.args.params[1].name + '\n'
                    code += '{' + obj.decl.type.args.params[1].name + '}' \
                        + ' @__get_args {' + obj.decl.type.args.params[0].name + '} =\n'
            else:
                code += '~' + obj.decl.name + '___END goto\n'
                
                if not obj.decl.name in functions:
                    functions += [obj.decl.name]
                current_function = obj.decl.name
                
                if type(obj.decl.type.type) == TypeDecl and type(obj.decl.type.type.type) == IdentifierType and ('float' in obj.decl.type.type.type.names or 'double' in obj.decl.type.type.type.names):
                    floats += [obj.decl.name]
                    savedfloats = floats.copy()
                    savedfloatptrs = floatptrs.copy()
                    savedfloatptrptrs = floatptrptrs.copy()
                elif type(obj.decl.type.type) == PtrDecl and type(obj.decl.type.type.type) == TypeDecl and type(obj.decl.type.type.type.type) == IdentifierType and ('float' in obj.decl.type.type.type.type.names or 'double' in obj.decl.type.type.type.type.names):
                    floatptrs += [obj.decl.name]
                    savedfloats = floats.copy()
                    savedfloatptrs = floatptrs.copy()
                    savedfloatptrptrs = floatptrptrs.copy()
                elif type(obj.decl.type.type) == PtrDecl and type(obj.decl.type.type.type) == PtrDecl and type(obj.decl.type.type.type.type) == TypeDecl and type(obj.decl.type.type.type.type.type) == IdentifierType and ('float' in obj.decl.type.type.type.type.type.names or 'double' in obj.decl.type.type.type.type.type.names):
                    floatptrptrs += [obj.decl.name]
                    savedfloats = floats.copy()
                    savedfloatptrs = floatptrs.copy()
                    savedfloatptrptrs = floatptrptrs.copy()
                elif type(obj.decl.type.type) == TypeDecl and type(obj.decl.type.type.type) == IdentifierType and 'unsigned' in obj.decl.type.type.type.names:
                    unss += [obj.decl.name]
                    savedunss = unss.copy()
                    savedunsptrs = unsptrs.copy()
                    savedunsptrptrs = unsptrptrs.copy()
                elif type(obj.decl.type.type) == PtrDecl and type(obj.decl.type.type.type) == TypeDecl and type(obj.decl.type.type.type.type) == IdentifierType and 'unsigned' in obj.decl.type.type.type.type.names:
                    unsptrs += [obj.decl.name]
                    savedunss = unss.copy()
                    savedunsptrs = unsptrs.copy()
                    savedunsptrptrs = unsptrptrs.copy()
                elif type(obj.decl.type.type) == PtrDecl and type(obj.decl.type.type.type) == PtrDecl and type(obj.decl.type.type.type.type) == TypeDecl and type(obj.decl.type.type.type.type.type) == IdentifierType and 'unsigned' in obj.decl.type.type.type.type.type.names:
                    unsptrptrs += [obj.decl.name]
                    savedunss = unss.copy()
                    savedunsptrs = unsptrs.copy()
                    savedunsptrptrs = unsptrptrs.copy()
                
                code += obj.decl.name + ': function\n'
                
                try:
                    i = 0
                    functions_floatparams[obj.decl.name] = []
                    for param in obj.decl.type.args.params:
                        if type(param) == EllipsisParam:
                            funcfixed[obj.decl.name] = i
                            code += create_var('___vargs', 126)
                            break
                        code += compile_obj(param, root=True) + '\n'
                        functions_floatparams[obj.decl.name] += [is_float(param)]
                        if not param.name in structuresnoptrs:
                            code += get_var(param.name) + ' =\n'
                        else:
                            for j in range(get_struct_length(structs[structures[param.name]])):
                                code += 'dup ' + str(j) + ' + . {' + param.name + '} ' + str(j) + ' + =\n'
                            code += 'drop\n'
                        i += 1
                except Exception: pass
            
            if obj.body.block_items != None:
                for item in obj.body.block_items:
                    code += compile_obj(item, root=True) + '\n'
            
            code += '\n0 ' + ('return' if current_function != 'main' else 'exit')
            
            if obj.decl.name != 'main':
                code += '\n' + obj.decl.name + '___END:\n'
            
            current_function = ''
            
            variables = savedvariables
            arrays = savedarrays
            structures = savedstructures
            structuresnoptrs = savedstructuresnoptrs
            enumerators = savedenumerators
            typedefs = savedtypedefs
            floats = savedfloats
            floatptrs = savedfloatptrs
            floatptrptrs = savedfloatptrptrs
            unss = savedunss
            unsptrs = savedunsptrs
            unsptrptrs = savedunsptrptrs
            
            return code
        # новый enum
        elif type(obj) == Decl and type(obj.type) == Enum:
            if obj.type.values != None:
                i = 0
                for item in obj.type.values.enumerators:
                    if item.value != None:
                        i = static_int(item.value)
                    enumerators[item.name] = i
                    i += 1
            return ''
        elif (type(obj) == Typedef) and type(obj.type.type) == Enum:
            if obj.type.type.values != None:
                i = 0
                for item in obj.type.type.values.enumerators:
                    if item.value != None:
                        i = static_int(item.value)
                    enumerators[item.name] = i
                    i += 1
            return ''
        # struct|union
        elif type(obj) == Decl and (type(obj.type) == Struct or type(obj.type) == Union):
            structs[obj.type.name] = obj.type.decls
            
            return ''
        #########################
        elif (type(obj) == Typedef) and type(obj.type) == TypeDecl and type(obj.type.type) == Enum:
            compile_obj(Decl(None, None, None, None, None, obj.type.type, None, None))
            return ''
        # структура
        elif type(obj) == Decl and type(obj.type) == TypeDecl and (type(obj.type.type) == Struct or type(obj.type.type) == Union):
            name = (obj.type.type.name if obj.type.type.name != None else obj.name + '__STRUCT')
            
            if obj.type.type.name != None and obj.type.type.decls != None:
                structs[obj.type.type.name] = obj.type.type.decls
            
            structures[obj.name] = name
            structuresnoptrs[obj.name] = name
            if obj.type.type.name == None:
                structs[name] = obj.type.type.decls
            
            code = ''
            
            code += '/alloc ' + obj.name + '[' + str(get_struct_length(structs[name])) + ']\n'
            
            if obj.init != None and type(obj.init) == InitList:
                for i in range(len(obj.init.exprs)):
                    expr = obj.init.exprs[i]
                    saved_i = i
                    if type(expr) == NamedInitializer:
                        i = 0
                        for decl in structs[name]:
                            if decl.name == expr.name[0].name:
                                break
                            i += 1
                    
                    code += compile_obj(expr) + ' {' + obj.name + '} ' + ((str(i) + ' + ') if i != 0 else '') + '=\n'
                    
                    if type(expr) == NamedInitializer:
                        i = saved_i
            elif obj.init != None:
                i = 0
                code += compile_obj(obj.init) + '\n'
                for decl in structs[structures[obj.name]]:
                    code += 'dup ' + str(i) + ' + . {' + obj.name + '} ' \
                    + str(i) + ' + =\n'
                    i += 1
                code += 'drop'
            return code
        # вставить enumerator
        elif type(obj) == ID and (obj.name in enumerators):
            return str(enumerators[obj.name])
        # вставить адрес функции
        elif type(obj) == ID and (obj.name == 'main' or obj.name in functions):
            code = ''
            return code + '\n~' + obj.name
        elif type(obj) == UnaryOp and obj.op == '&' and type(obj.expr) == ID and (obj.expr.name == 'main' or obj.expr.name in functions):
            code = ''
            return code + '\n~' + obj.expr.name
        # присваивание (копирование структуры)
        elif type(obj) == Assignment and obj.op == '=' and type(obj.lvalue) == ID and obj.lvalue.name in structuresnoptrs:
            code = compile_obj(obj.rvalue) + '\n'
            for i in range(get_struct_length(structs[structures[obj.lvalue.name]])):
                code += 'dup ' + str(i) + ' + . ' + compile_obj(obj.lvalue) + ' ' \
                + str(i) + ' + =\n'
            code += 'drop'
            return code
        # присваивание
        elif type(obj) == Assignment and obj.op == '=':
            return compile_obj(obj.lvalue, uns=is_uns(obj))[:-2] + ' ' + ('dup' if not root else '') + ' ' + compile_obj(obj.rvalue) + ' swap = ' + ('.' if not root else '')
        elif type(obj) == Assignment and obj.op[0] in '+-/*^%|&<>' and obj.op.endswith('='):
            return compile_obj(obj.lvalue, uns=is_uns(obj))[:-2] + ' dup ' + ('dup' if not root else '') + ' . ' + compile_obj(obj.rvalue) + ' ' + obj.op[0].replace('/', ('/' if not is_uns(obj) else 'u/')).replace('%', ('rem' if not is_uns(obj) else 'urem')).replace('&', 'and').replace('<', 'lsh').replace('>', 'rsh') + ' swap = ' + ('.' if not root else '')
        # сложение, вычитание и др.
        elif type(obj) == BinaryOp and obj.op in '-+/*^|%':
            return compile_obj(obj.left) + ' ' + compile_obj(obj.right) + ' ' + obj.op.replace('/', ('/' if not is_uns(obj) else 'u/')).replace('%', ('rem' if not is_uns(obj) else 'urem'))
        elif type(obj) == BinaryOp and obj.op == '<<':
            return compile_obj(obj.left) + ' ' + compile_obj(obj.right) + ' lsh'
        elif type(obj) == BinaryOp and obj.op == '>>':
            return compile_obj(obj.left) + ' ' + compile_obj(obj.right) + ' rsh'
        elif type(obj) == BinaryOp and obj.op == '&':
            return compile_obj(obj.left) + ' ' + compile_obj(obj.right) + ' and'
        # if
        elif type(obj) == If:
            code = ''
            saved = current_if
            current_if += 1
            code += compile_cond(obj.cond)
            
            code += ' ~___else' + str(saved) + ' else ' + (';' if current_function == 'main' else '') + '\n'
            
            if type(obj.iftrue) == Compound:
                for item in obj.iftrue.block_items:
                    code += '\t' + compile_obj(item, root=True) + '\n'
            else:
                code += '\t' + compile_obj(obj.iftrue, root=True) + '\n'
            
            code += '~___endif' + str(saved) + ' goto ___else' + str(saved) + ': ' + (';' if current_function == 'main' else '') + '\n'
            
            if obj.iffalse != None and type(obj.iffalse) == Compound:
                for item in obj.iffalse.block_items:
                    code += compile_obj(item, root=True) + '\n'
            elif obj.iffalse != None:
                code += compile_obj(obj.iffalse, root=True) + '\n'
            
            code += '___endif' + str(saved) + ':\n'
            
            return code
        # строка
        elif type(obj) == Constant and obj.type == 'string' and not root:
            current_string += 1
            s = preprocess_string(obj.value)
            # для строк, содержащих '\n', '\b' и др.
            for c in s:
                if ord(c) < 32 or ord(c) >= 127 or c == '<' or c == '>' or c == '%':
                    code = '\n'
                    code += '/alloc ___s' + str(current_string) + '[' + str((len(s) + 1)) + ']\n'
                    i = 0
                    for ch in s:
                        code += str(ord(ch)) + ' ({___s' + str(current_string) + '} ' + str(i) + ' +) =\n'
                        i += 1
                    code += '0 ({___s' + str(current_string) + '} ' + str(i) + ' +) =\n'
                    code += '{___s' + str(current_string) + '}'
                    return code
            return '\n"' + s.replace('"', '`') + '" ___s' + str(current_string) + '\n&___s' + str(current_string)
        # return
        elif type(obj) == Return:
            return (compile_obj(obj.expr, flt=is_float(current_function)) if obj.expr != None else '0') + ' ' + ('return' if current_function != 'main' else 'exit')
        # FuncDecl
        elif type(obj) == Decl and type(obj.type) == FuncDecl:
            functions += [obj.name]
            if type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and ('float' in obj.type.type.type.names or 'double' in obj.type.type.type.names):
                floats += [obj.name]
            elif type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and ('float' in obj.type.type.type.type.names or 'double' in obj.type.type.type.type.names):
                floatptrs += [obj.name]
            elif type(obj.type.type) == PtrDecl and type(obj.type.type.type) == PtrDecl and type(obj.type.type.type.type) == TypeDecl and type(obj.type.type.type.type.type) == IdentifierType and ('float' in obj.type.type.type.type.type.names or 'double' in obj.type.type.type.type.type.names):
                floatptrptrs += [obj.name]
            elif type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.names:
                unss += [obj.name]
            elif type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.type.names:
                unsptrs += [obj.name]
            elif type(obj.type.type) == PtrDecl and type(obj.type.type.type) == PtrDecl and type(obj.type.type.type.type) == TypeDecl and type(obj.type.type.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.type.type.names:
                unsptrptrs += [obj.name]
            
            try:
                i = 0
                functions_floatparams[obj.name] = []
                for param in obj.type.args.params:
                    if type(param) == EllipsisParam:
                        funcfixed[obj.name] = i
                        break
                    functions_floatparams[obj.name] += [is_float(param)]
                    i += 1
            except Exception: pass
            return ''
        # создание переменной/массива
        elif type(obj) == DeclList:
            code = ''
            for item in obj.decls:
                code += compile_obj(item, root=root) + '\n'
            return code
        elif type(obj) == Decl and type(obj.type) == ArrayDecl and type(obj.type.type) == TypeDecl and (type(obj.type.type.type) == Struct or type(obj.type.type.type) == Union):
            name = (obj.type.type.type.name if obj.type.type.type.name != None else obj.name + '__STRUCT')
            
            if obj.type.type.type.name != None and obj.type.type.type.decls != None:
                structs[obj.type.type.type.name] = obj.type.type.type.decls
            
            structures[obj.name] = name
            structuresnoptrs[obj.name] = name
            if obj.type.type.type.name == None:
                structs[name] = obj.type.type.type.decls
            
            return '/alloc ' + obj.name + '[' + str(get_struct_length(structs[name]) * static_int(obj.type.dim)) + ']\n'
        elif type(obj) == Decl and type(obj.type) == ArrayDecl and (obj.type.dim != None or obj.init != None):
            code = create_var(obj.name, (static_int(obj.type.dim) if obj.type.dim != None else \
              (len(obj.init.exprs) if type(obj.init) == InitList else len(preprocess_string(obj.init.value)) + 1))) + '\n'
            
            if type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and ('float' in obj.type.type.type.names or 'double' in obj.type.type.type.names):
                floatptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and ('float' in obj.type.type.type.type.names or 'double' in obj.type.type.type.type.names):
                floatptrptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.names:
                unsptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.type.names:
                unsptrptrs += [get_var(obj.name)[1:-1]]
            
            if obj.init != None and type(obj.init) == InitList:
                code += get_var(obj.name) + ' 0 ' + get_var(obj.name)[:-1] + '.length}' + ' memset\n'
                for i in range(len(obj.init.exprs)):
                    if not (type(obj.init.exprs[i]) == Constant and obj.init.exprs[i].type == 'int' and obj.init.exprs[i].value == '0'):
                        code += compile_obj(obj.init.exprs[i], flt=(get_var(obj.name)[1:-1] in floatptrs or get_var(obj.name)[1:-1] in floatptrptrs)) + ' (' + get_var(obj.name) + ' ' \
                        + (str(i) if type(obj.init.exprs[i]) != NamedInitializer else compile_obj(obj.init.exprs[i].name[0])) \
                        + ' +) =\n'
            elif obj.init != None and type(obj.init) == Constant:
                for i in range(len(preprocess_string(obj.init.value))):
                    code += str(ord(preprocess_string(obj.init.value)[i])) + ' (' + get_var(obj.name) + ' ' + str(i) + ' +) =\n'
                code += '0 (' + get_var(obj.name) + ' ' + str(len(preprocess_string(obj.init.value))) + ' +) =\n'
            
            # если массив является двумерным
            if type(obj.type.type) == ArrayDecl:
                for i in range(static_int(obj.type.dim)):
                    code += create_var(obj.name + '__A_' + str(i), static_int(obj.type.type.dim)) \
                        + get_var(obj.name + '__A_' + str(i)) + ' ' \
                        + (get_var(obj.name) + ' ' + str(i) + ' +') \
                        + ' =\n'
            return code
        elif type(obj) == Decl and (current_function != '' and current_function != 'main') and not 'static' in obj.storage:
            if type(obj.type) == PtrDecl and type(obj.type.type) == TypeDecl and (type(obj.type.type.type) == Struct or type(obj.type.type.type) == Union):
                name = (obj.type.type.type.name if obj.type.type.type.name != None else obj.name + '__STRUCT')
                
                if obj.type.type.type.name != None and obj.type.type.type.decls != None:
                    structs[obj.type.type.type.name] = obj.type.type.type.decls
                
                structures[obj.name] = name
                if obj.type.type.type.name == None:
                    structs[name] = obj.type.type.type.decls
                
                if obj.name in structuresnoptrs:
                    del structuresnoptrs[obj.name]
            
            code = ''
            if type(obj.type) == TypeDecl and type(obj.type.type) == Enum:
                compile_obj(Decl(None, None, None, None, None, obj.type.type, None, None))
            variables += [current_function + '.' + obj.name]
            
            if type(obj.type) == TypeDecl and type(obj.type.type) == IdentifierType and ('float' in obj.type.type.names or 'double' in obj.type.type.names):
                floats += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and ('float' in obj.type.type.type.names or 'double' in obj.type.type.type.names):
                floatptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and ('float' in obj.type.type.type.type.names or 'double' in obj.type.type.type.type.names):
                floatptrptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == TypeDecl and type(obj.type.type) == IdentifierType and 'unsigned' in obj.type.type.names:
                unss += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.names:
                unsptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.type.names:
                unsptrptrs += [get_var(obj.name)[1:-1]]
            
            code += '/alloc ' + current_function + '.' + obj.name + '___ARRAY__[128]\n'
            code += '/define ' + current_function + '.' + obj.name + ' :{' \
                + current_function + '.' + obj.name + '___ARRAY__} retptr +\n'
            if obj.init != None:
                code += (compile_obj(obj.init, flt=is_float(obj)) if obj.init != None else '0') + ' ' + get_var(obj.name) + ' =\n'
            
            return code
        elif type(obj) == Decl:
            if type(obj.type) == PtrDecl and type(obj.type.type) == TypeDecl and (type(obj.type.type.type) == Struct or type(obj.type.type.type) == Union):
                name = (obj.type.type.type.name if obj.type.type.type.name != None else obj.name + '__STRUCT')
                
                if obj.type.type.type.name != None and obj.type.type.type.decls != None:
                    structs[obj.type.type.type.name] = obj.type.type.type.decls
                
                structures[obj.name] = name
                if obj.type.type.type.name == None:
                    structs[name] = obj.type.type.type.decls
                
                if obj.name in structuresnoptrs:
                    del structuresnoptrs[obj.name]
            
            code = ''
            if type(obj.type) == TypeDecl and type(obj.type.type) == Enum:
                if obj.type.type.values != None:
                    i = 0
                    for item in obj.type.type.values.enumerators:
                        if item.value != None:
                            i = static_int(item.value)
                        enumerators[item.name] = i
                        i += 1
            code += create_var(obj.name)
            
            if type(obj.type) == TypeDecl and type(obj.type.type) == IdentifierType and ('float' in obj.type.type.names or 'double' in obj.type.type.names):
                floats += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and ('float' in obj.type.type.type.names or 'double' in obj.type.type.type.names):
                floatptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and ('float' in obj.type.type.type.type.names or 'double' in obj.type.type.type.type.names):
                floatptrptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == TypeDecl and type(obj.type.type) == IdentifierType and 'unsigned' in obj.type.type.names:
                unss += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == TypeDecl and type(obj.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.names:
                unsptrs += [get_var(obj.name)[1:-1]]
            elif type(obj.type) == PtrDecl and type(obj.type.type) == PtrDecl and type(obj.type.type.type) == TypeDecl and type(obj.type.type.type.type) == IdentifierType and 'unsigned' in obj.type.type.type.type.names:
                unsptrptrs += [get_var(obj.name)[1:-1]]
            
            if current_function == '' or obj.init != None:
                code += (compile_obj(obj.init, flt=is_float(obj)) if obj.init != None else '0') + ' ' + get_var(obj.name) + ' =\n'
            return code
        ######################################################
        elif type(obj) == Cast:
            return compile_obj(obj.expr, root=root, flt=is_float(obj.to_type))
        # тернарный оператор
        elif type(obj) == TernaryOp:
            code = ''
            
            saved = current_if
            current_if += 1
            
            code += compile_cond(obj.cond) + ' ~___tElse' + str(saved) + ' else '
            code += compile_obj(obj.iftrue, flt=flt) + ' ~___tEndif' + str(saved) + ' goto ___tElse' + str(saved) + ': '
            code += compile_obj(obj.iffalse, flt=flt) + ' ___tEndif' + str(saved) + ':'
            
            return code
        # элемент массива
        elif type(obj) == ArrayRef and not root:
            return compile_obj(obj.name) + ' ' + compile_obj(obj.subscript) \
            + ((' ' + str(get_struct_length(structs[structures[obj.name.name]])) + ' *') if type(obj.name) == ID and \
            obj.name.name in structures else '') + ' + .'
        # -выражение
        elif type(obj) == UnaryOp and obj.op == '-':
            return compile_obj(obj.expr, flt=flt, root=root) + ' neg'
        # +выражение
        elif type(obj) == UnaryOp and obj.op == '+':
            return compile_obj(obj.expr, flt=flt, root=root)
        # ~выражение
        elif type(obj) == UnaryOp and obj.op == '~':
            return compile_obj(obj.expr, root=root) + ' neg --'
        # поле объединения/структуры
        elif type(obj) == StructRef and not root:
            i = 0
            j = 0
            struct = get_struct(obj.name)
            
            while struct[j].name != obj.field.name:
                struct[j].type = preprocess_typedefs(struct[j].type)
                if type(struct[j].type) == ArrayDecl:
                    i += static_int(struct[j].type.dim)
                elif type(struct[j].type) == TypeDecl and (type(struct[j].type.type) == Struct or type(struct[j].type.type) == Union):
                    for d in (structs[struct[j].type.type.name] if struct[j].type.type.name != None else struct[j].type.type.decls):
                        if type(d.type) == ArrayDecl:
                            i += static_int(d.type.dim)
                        else:
                            i += 1
                else:
                    i += 1
                j += 1
            
            return compile_obj(obj.name)[:(-2 if obj.type == '.' else None)] + ' ' + ((str(i) + ' + ') if i != 0 else '') \
            + ('.' if type(struct[j].type) != ArrayDecl else ' ')
        # вызов функции (1)
        elif type(obj) == FuncCall and (type(obj.name) != ID or (obj.name.name in variables or (current_function + '.' + obj.name.name) in variables)):
            code = ''
            
            exprs = []
            if obj.args != None:
                exprs += obj.args.exprs
            exprs.reverse()
            
            for o in exprs:
                code += compile_obj(o, flt=is_float(o)) + '\n'
            
            code += '~____C' + str(continuel) + ' ' + compile_obj(obj.name) + ' goto ____C' + str(continuel) + ':\n'
            continuel += 1
            
            return code
        ###################
        elif type(obj) == ID and (obj.name in structuresnoptrs or is_array(obj.name)) and not root:
            return get_var(obj.name) + '  '
        # переменная
        elif type(obj) == ID and not root:
            return get_var(obj.name) + ' .'
        # создание метки и переход
        elif type(obj) == Label:
            return '___L' + current_function + '___' + obj.name + ':\n' + compile_obj(obj.stmt)
        elif type(obj) == Goto:
            return '~___L' + current_function + '___' + obj.name + ' goto'
        elif type(obj) == FuncCall and obj.name.name == '__jump' and not obj.name.name in functions:
            return compile_obj(obj.args.exprs[0]) + ' goto'
        ###################################
        elif type(obj) == FuncCall and obj.name.name == '__extern_label' and not obj.name.name in functions:
            return '<' + obj.args.exprs[0].value[1:-1] + '>'
        elif type(obj) == FuncCall and obj.name.name == '_call':
            code = ''
            exprs = []
            if obj.args != None:
                exprs += obj.args.exprs[1:]
            if obj.name.name in functions:
                exprs.reverse()
            for o in exprs:
                code += compile_obj(o, flt=is_float(o)) + ' '
            code += preprocess_string(obj.args.exprs[0].value)
            return code
        # вызов функции (2)
        elif type(obj) == FuncCall:
            code = ''
            
            exprs = []
            vargs = []
            if obj.args != None:
                exprs += obj.args.exprs
            if obj.name.name in functions:
                if obj.name.name in funcfixed:
                    vargs += exprs[funcfixed[obj.name.name]:]
                    exprs = exprs[:funcfixed[obj.name.name]]
                exprs.reverse()
            i = 1
            for o in exprs:
                code += compile_obj(o, flt=(functions_floatparams[obj.name.name][-i] if obj.name.name in functions else is_float(o))) + '\n'
                i += 1
            i = 0
            for o in vargs:
                code += compile_obj(o, flt=is_float(o)) + ' ({' + obj.name.name + '.___vargs} ' + str(i) + ' +) =\n'
                i += 1
            code += ('@' if obj.name.name in functions else '') + obj.name.name
            if (obj.name.name in functions or obj.name.name == 'memset' or obj.name.name == 'memcpy' or obj.name.name == 'getc' or obj.name.name == 'h256_init') and root:
                code += ' drop'
            return code
        # инкремент и декремент
        elif type(obj) == UnaryOp and obj.op == '++':
            return '' + compile_obj(obj.expr, uns=is_uns(obj))[:-2] + ' ' + ('dup ' if not root else ' ') + 'dup . ++ swap =' + (' .' if not root else '')
        elif type(obj) == UnaryOp and obj.op == '--':
            return '' + compile_obj(obj.expr, uns=is_uns(obj))[:-2] + ' ' + ('dup ' if not root else ' ') + 'dup . -- swap =' + (' .' if not root else '')
        elif type(obj) == UnaryOp and obj.op == 'p++':
            return '' + compile_obj(obj.expr, uns=is_uns(obj))[:-2] + ' ' + ('dup . swap ' if not root else ' ') + 'dup . ++ swap ='
        elif type(obj) == UnaryOp and obj.op == 'p--':
            return '' + compile_obj(obj.expr, uns=is_uns(obj))[:-2] + ' ' + ('dup . swap ' if not root else ' ') + 'dup . -- swap ='
        # получение адреса переменной/массива/элемента массива/структуры
        elif type(obj) == UnaryOp and obj.op == '&' and type(obj.expr) == ID and obj.expr.name in structures:
            return '{' + obj.expr.name + '}'
        elif type(obj) == UnaryOp and obj.op == '&':
            return compile_obj(obj.expr, flt=is_float(obj.expr), uns=is_uns(obj.expr))[:-2]
        # *expr
        elif type(obj) == UnaryOp and obj.op == '*':
            return compile_obj(obj.expr, flt=is_float(obj.expr)) + ' .'
        # while
        elif type(obj) == While:
            code = ''
            saved = current_while
            current_while += 1
            old_continue = current_continue
            old_break = current_break
            current_continue = '___while' + str(saved)
            current_break = '___endwhile' + str(saved)
            code += '___while' + str(saved) + ': ' + compile_cond(obj.cond)
            
            code += ' ~___endwhile' + str(saved) + ' else ' + (';' if current_function == 'main' else '') + '\n'
            
            if type(obj.stmt) == Compound:
                for item in obj.stmt.block_items:
                    current_continue = '___while' + str(saved)
                    current_break = '___endwhile' + str(saved)
                    code += '\t' + compile_obj(item, root=True) + '\n'
            else:
                code += '\t' + compile_obj(obj.stmt, root=True) + '\n'
            
            current_continue = old_continue
            current_break = old_break
            
            code += '~___while' + str(saved) + ' goto ___endwhile' + str(saved) + ':'
            
            return code
        # do-while
        elif type(obj) == DoWhile:
            code = ''
            saved = current_while
            current_while += 1
            old_continue = current_continue
            old_break = current_break
            current_continue = '___dowhile' + str(saved)
            current_break = '___enddowhile' + str(saved)
            code += '___dowhile' + str(saved) + ':\n'
            
            if type(obj.stmt) == Compound:
                for item in (obj.stmt.block_items if obj.stmt.block_items != None else []):
                    code += '\t' + compile_obj(item, root=True) + '\n'
            else:
                code += '\t' + compile_obj(obj.stmt, root=True) + '\n'
            
            code += compile_cond(obj.cond) + ' ~___dowhile' + str(saved) + ' then ___enddowhile' + str(saved) + ':\n'
            
            current_continue = old_continue
            current_break = old_break
            
            return code
        # for
        elif type(obj) == For:
            code = ''
            saved = current_for
            current_for += 1
            old_continue = current_continue
            old_break = current_break
            current_continue = '___preendfor' + str(saved)
            current_break = '___endfor' + str(saved)
            code += compile_obj(obj.init, root=True) + ' '
            code += '___for' + str(saved) + ': ' + compile_cond(obj.cond)
            
            code += ' ~___endfor' + str(saved) + ' else ' + (';' if current_function == 'main' else '') + '\n'
            
            if type(obj.stmt) == Compound:
                for item in (obj.stmt.block_items if obj.stmt.block_items != None else []):
                    current_continue = '___preendfor' + str(saved)
                    current_break = '___endfor' + str(saved)
                    code += '\t' + compile_obj(item, root=True) + '\n'
            else:
                code += '\t' + compile_obj(obj.stmt, root=True) + '\n'
            
            code += '___preendfor' + str(saved) + ': ' + compile_obj(obj.next, root=True) + ' ~___for' + str(saved) + ' goto ___endfor' + str(saved) + ':'
            
            current_continue = old_continue
            current_break = old_break
            
            return code
        # switch
        elif type(obj) == Switch:
            code = ''
            
            saved = current_switchl
            current_switchl += 1
            
            i = 0
            
            code += '/alloc ___switchv' + str(saved) + '\n'
            code += compile_obj(obj.cond) + ' {___switchv' + str(saved) + '} =\n'
            
            for item in (obj.stmt.block_items if type(obj.stmt) == Compound else [obj.stmt]):
                if type(item) == Case:
                    code += '{___switchv' + str(saved) + '} . ' + compile_obj(item.expr) + ' =? ~___switchl' + str(saved) + '_' + str(i) + ' then\n'
                elif type(item) != Default:
                    code += compile_obj(item) + '\n'
                i += 1
            i = 0
            
            for item in (obj.stmt.block_items if type(obj.stmt) == Compound else [obj.stmt]):
                if type(item) == Default:
                    code += '~___switchl' + str(saved) + '_' + str(i) + ' goto\n'
                
                i += 1
            
            code += '~___endswitchl' + str(saved) + ' goto\n'
            
            i = 0
            
            old_break = current_break
            current_break = '___endswitchl' + str(saved)
            
            for item in (obj.stmt.block_items if type(obj.stmt) == Compound else [obj.stmt]):
                code += '___switchl' + str(saved) + '_' + str(i) + ':\n'
                try:
                    for o in item.stmts:
                        code += '\t' + compile_obj(o, root=True) + '\n'
                except Exception: pass
                
                i += 1
            
            current_break = old_break
            
            code += '___endswitchl' + str(saved) + ':\n'
            
            return code
        ####################
        elif type(obj) == Continue:
            return '~' + current_continue + ' goto'
        elif type(obj) == Break:
            return '~' + current_break + ' goto'
        elif type(obj) == BinaryOp or type(obj) == UnaryOp:
            return compile_cond(obj)
        elif type(obj) == EmptyStatement:
            return ''
        else:
            return '# (unknown) #\n'
    except Exception:
        return '# (error) #\n'

###################################################################

# обработать директивы в коде (XmConC)
def preprocess(code):
    code = code.replace('\t', '').replace('\\\n', '').split('\n')
    
    result = ''
    
    allocptr = 8700000
    defines = {}
    
    for line in code:
        line = line.strip()
        if line.startswith('/define '):
            defines[line.split(' ')[1]] = line[(line.find(':') + 1):].replace('\\n', '\n')
        elif line.startswith('/alloc ') and not '[' in line.split(' ')[1]:
            allocptr -= 1
            defines[line.split(' ')[1]] = str(allocptr).zfill(7)
        elif line.startswith('/alloc '):
            allocptr -= int(line.split(' ')[1].split('[')[1].split(']')[0], base=0)
            defines[line.split(' ')[1].split('[')[0]] = str(allocptr).zfill(7)
            defines[line.split(' ')[1].split('[')[0] + '.length'] = line.split(' ')[1].split('[')[1].split(']')[0]
    
    for line in code:
        line = line.strip()
        if not line.startswith('#') and not line.startswith('/') and line != '':
            for i in range(4):
                for name in defines:
                    line = line.replace('{' + name + '}!', defines[name] + ' .')
                    line = line.replace('{' + name + '}', defines[name])
            result += line + '\n'
    
    return result[:-1]

# получить древо кода (XmConC)
def maketree(code):
    tree = []
    continue_label = 0
    # формат элемента древа:
    #   [0] строка, определяющая тип операции
    #       ('asm', 'string' и т. д.)
    #   [1] является массивом аргументов операции
    #       (например, у 'label' это одна строка)
    for line in code.split('\n'):
        if line == '':
            continue
        elif line.startswith('"'):
            tree += [['string', [line.split('"')[2].strip(), line.split('"')[1]]]]
        elif line.startswith('$'):
            tree += [['asm', [line[1:].strip()]]]
        else:
            line = line.replace("'\\0'", str(0)).replace("';'", str(ord(';'))).replace(' ;', ';').replace(';', ' ;')
            for word in line.split(' '):
                word = word.replace('(', '').replace(')', '')
                
                if word == '':
                    continue
                elif word[0].isdigit() or (word[0] == '-' and len(word) > 1 and word[1].isdigit()):
                    tree += [['push_number', [int(word, base=0)]]]
                elif word.startswith('#'):
                    break
                elif word[0] == "'":
                    tree += [['push_number', [ord(word[1])]]]
                elif word[0] == "&":
                    tree += [['push_string_addr', [word[1:]]]]
                elif word[0] == "~":
                    tree += [['push_label', [word[1:]]]]
                elif word.startswith('<') and word.endswith('>'):
                    tree += [['push_extern_label', [word[1:-1]]]]
                elif word[0] == "@":
                    tree += [['push_label', ['__C' + str(continue_label)]]]
                    tree += [['push_label', [word[1:]]]]
                    tree += [['call', ['goto']]]
                    tree += [['label', ['__C' + str(continue_label)]]]
                    continue_label += 1
                elif word == ';':
                    tree += [['reset_stack_pointer', []]]
                elif word.endswith(':'):
                    tree += [['label', [word.replace(':', '')]]]
                else:
                    tree += [['call', [word]]]
    return tree

# перевести в ассемблерный код Makexm2c
def compile_for_xmtwolime(prog_name, tree, outfile):
    def asm(code):
        print(code, file=outfile)
    
    # получить номер п. регистра
    def getreg(base):
        return '%R_FA_' + str(base) + '%'
    
    # получить регистр хранения указателя стека
    def getrstackptr():
        return getreg(9)
    
    # получить начало стека
    def getstackstart():
        return 6900128
    
    # получить регистр для хранения адреса возврата
    def getrret():
        return getreg(8)
    
    def getrfret():
        return getreg(6)
    
    ###########################
    
    asm(prog_name + ':')
    asm('mov ' + getrstackptr() + ', ' + str(getstackstart()).zfill(7))
    asm('mov %R_FA_7%, %OUT_ST%')  # сброс указателя вывода
    asm('mov ' + getrfret() + ', ' + str(getstackstart() - 128))
    
    ###########################
    
    for block in tree:
        if block[0] == 'label':
            asm(prog_name + '_l' + block[1][0] + ':')
        elif block[0] == 'string':
            asm(prog_name + '_S' + block[1][0] + ':')
            asm('.skip ' + str(len(block[1][1]) + 1))
            if len(block[1][1]) > 0:
                asm('.ascii <' + prog_name + '_S' + block[1][0] + '> "' + block[1][1] + '"')
        elif block[0] == 'asm':
            asm(block[1][0])
        elif block[0] == 'push_number':
            if block[1][0] >= 0:
                asm('mov ' + getreg(0) + ', ' + str(block[1][0]))
            else:
                asm('mov ' + getreg(0) + ', ' + str(-block[1][0]))
                asm('tnp ' + getreg(0) + ', ' + getreg(0))
            asm('push ' + getreg(0) + ', ' + getrstackptr() + ', 1')
        elif block[0] == 'push_label':
            asm('mov ' + getreg(0) + ', <' + prog_name + '_l' + block[1][0] + '>')
            asm('push ' + getreg(0) + ', ' + getrstackptr() + ', 1')
        elif block[0] == 'push_extern_label':
            asm('mov ' + getreg(0) + ', <' + block[1][0] + '>')
            asm('push ' + getreg(0) + ', ' + getrstackptr() + ', 1')
        elif block[0] == 'push_string_addr':
            asm('mov ' + getreg(0) + ', <' + prog_name + '_S' + block[1][0] + '>')
            asm('push ' + getreg(0) + ', ' + getrstackptr() + ', 1')
        elif block[0] == 'reset_stack_pointer':
            asm('mov ' + getrstackptr() + ', ' + str(getstackstart()).zfill(7))
        elif block[0] == 'call' and (block[1][0] == 'goto' or block[1][0] == 'xm2_code'):
            asm('pop ' + getrstackptr() + ', ' + getrret() + ', 1')
            asm('jmp ' + getrret())
        elif block[0] == 'call' and block[1][0] == 'function':
            asm('pop ' + getrstackptr() + ', ' + getreg(0) + ', 1')
            asm('push ' + getreg(0) + ', ' + getrfret() + ', 1')
        elif block[0] == 'call' and block[1][0] == 'return':
            asm('pop ' + getrfret() + ', ' + getreg(0) + ', 1')
            asm('jmp ' + getreg(0))
        elif block[0] == 'call' and block[1][0] == 'retptr':
            asm('mov ' + getreg(0) + ', ' + str(getstackstart() - 128))
            asm('sub ' + getrfret() + ' ' + getreg(0) + ', ' + getreg(0))
            asm('push ' + getreg(0) + ', ' + getrstackptr() + ', 1')
        elif block[0] == 'call':
            asm('call ' + getrret() + ', <__0_' + block[1][0] + '>')

################################################################################

if __name__ == '__main__':
    import sys
    from pycparser import parse_file
    
    if len(sys.argv) == 1:
        print('usage: ./xm2cc.py PROG_NAME \'CPP_ARGS\' FILE... [> OUT_FILE]')
        sys.exit(1)
    
    cppargs = ['-undef', '-D__XCC_C__=1']
    if sys.argv[2] != '':
        cppargs += sys.argv[2].split(' ')
    
    code = ''
    for filename in sys.argv[3:]:
        ast = parse_file(filename, use_cpp=True, cpp_args=cppargs)
        
        for item in ast:
            code += compile_obj(item, root=True) + '\n'
        
        current_function = ''
        variables = []
        functions = []
        arrays = []
        floats = []
        floatptrs = []
        floatptrptrs = []
        unss = []
        unsptrs = []
        unsptrptrs = []
        functions_floatparams = {}
        funcfixed = {}
        enumerators = {}
        structs = {}
        structures = {}
        structuresnoptrs = {}
        typedefs = {}
    #print(code)
    compile_for_xmtwolime(sys.argv[1], maketree(preprocess(code)), sys.stdout)


