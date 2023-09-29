def log(name, info):
    if isinstance(info, (str)):
        print(f'{name} = "{info}"')
    elif isinstance(info, (list)):
        print(f'{name} = [')
        for i in info:
            print(f'\t{i}')
        print(f']')
    elif isinstance(info, (dict)):
        print(f'{name} = {{')
        for key in info:
            print(f'\t{key}: {info[key]}')
        print(f'}}')
    else:
        print(f'{name} = {info}')