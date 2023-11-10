i = 1
g_list = {}

while True:
    try:
        item = input().strip().upper()
        g_list[item] = 1 + g_list.get(item, 0)
    except EOFError:
        break

g_list_keys = sorted(g_list.keys())

for key in g_list_keys:
    print(g_list[key], key)
