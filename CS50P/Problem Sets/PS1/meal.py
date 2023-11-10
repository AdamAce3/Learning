def main():
    time = convert(input("What time is it? ").strip().casefold())
    if 7.00 <= time <= 8.00:
        print("breakfast time")
    elif 12.00 <= time <= 13.00:
        print("lunch time")
    elif 18.00 <= time <= 19.00:
        print("dinner time")
    else:
        print("It's not time to eat!")


def convert(time):
    if time.endswith("a.m."):
        time = time.removesuffix("a.m.").strip()
        h, m = time.split(":")
        h = float(h)
        m = float(m)
        m_asDec = m/60
        return h + m_asDec
    elif time.endswith("p.m."):
        time = time.removesuffix("p.m.").strip()
        h, m = time.split(":")
        h = float(h) + 12
        m = float(m)
        m_asDec = m/60
        return h + m_asDec
    else:
        h, m = time.split(":")
        h = float(h)
        m = float(m)
        m_asDec = m/60
        return h + m_asDec

if __name__ == "__main__": #Why do I need this?
    main()