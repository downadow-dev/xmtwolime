#!/usr/bin/python3

import sys

# сначала выводим текст boot и ядра
f = open(sys.argv[1], 'rt')
print(f.read())
f.close()

f = open(sys.argv[2], 'rt')
print(f.read())
f.close()
###################################

print('system_start:')
# выводим код сброса нажатой клавиши и стирания '█'
print('\t\t\t\tmov %R_KEY%, 0')

print('\t\t\t\tvsv %R_ZERO%, UR15')
print('\t\t\t\tmov %R_KEY%, 1')
print('\t\t\t\tvsv %R_KEY%, 1901')
###################################################

apps_str = ''
j = 0
# а после уже текст проверки
for arg in sys.argv[3:]:
    filename = arg.split('/')[-1]
    
    print('\t\t\t\t_appChecking' + str(j) + ':')
    print('\t\t\t\t\tvld 0002, UR21')
    print('\t\t\t\t\tvld 0003, UR22')
    print('\t\t\t\t\tvld 0004, UR23')
    
    print('\t\t\t\t\tmov UR17, <_appChecking' + str(j + 1) + '>')
    
    # печатать код проверки
    print('\t\t\t\t\tmov UR20, ' + str(ord(filename[0])))
    print('\t\t\t\t\tif UR21 > UR20, UR17')
    print('\t\t\t\t\tif UR21 < UR20, UR17')
    
    print('\t\t\t\t\tmov UR20, ' + str(ord(filename[1])))
    print('\t\t\t\t\tif UR22 > UR20, UR17')
    print('\t\t\t\t\tif UR22 < UR20, UR17')
    
    print('\t\t\t\t\tmov UR20, ' + str(ord(filename[2])))
    print('\t\t\t\t\tif UR23 > UR20, UR17')
    print('\t\t\t\t\tif UR23 < UR20, UR17')
    
    print('\t\t\t\t\tmov UR17, <_term_applicationCompleted>')
    print('\t\t\t\t\tmov UR21, <' + filename[0] + filename[1] + filename[2] + '>')
    print('\t\t\t\t\tjmp UR21')
    
    apps_str += '' + filename[0] + filename[1] + filename[2] + ':<' + filename[0] + filename[1] + filename[2] + '>;'
    
    j += 1

# напечатать код, который будет исполняться, если команда не найдена
print('\t\t\t\t_appChecking' + str(j) + ':')
print('\t\t\t\t\tmov UR17, \'?\'')
print('\t\t\t\t\tvsv UR17, %OUT_ST%')
print('\t\t\t\t\tmov UR17, <_term_input>')
print('\t\t\t\t\tjmp UR17')

# конец кода ядра
print('.orig 40000')
print('lastReturnCode:')
print('.byte 0')

# печатать исходные коды приложений
for arg in sys.argv[3:]:
    f = open(arg, 'rt')
    print(f.read())
    f.close()

print('system_apps:')
print('.skip ' + str(len(apps_str.replace('<', '000')) + 1))
print('.ascii <system_apps> \"' + apps_str.replace('"', '_') + '\"')

print('system_appsEnd:')
