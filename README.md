# My Life Assistant

*Celebrate and experience life to its fullest, every 30 days.*

This is the **Simple App**, the first of three stages in the My Life Assistant plan. It's an extension of My Life Planner, built phone-first.

## What it does

- **Try Me sign-up:** your name, an optional email, and what you want more of this year
- **Monthly reflection:** the seven My Life Planner prompts (top accomplishments, biggest challenge, appreciations & gratitude, passions, connections, lessons learned, to do differently next month)
- **10 favourite photos a month:** shrunk on the phone before saving
- **My Year:** a 12-month spread that fills up as you go, and becomes the annual keepsake album
- **Celebrations:** birthdays, anniversaries and other days, with a gift budget and a countdown
- **Me:** profile, groups and experiences you'd join, and the membership tiers (Lifestyle, Elite, Luxury are marked coming soon)

## Where data is saved right now

Everything is saved **on the person's own phone** (browser storage). That works for trying the app, but it doesn't move between devices and is lost if the browser data is cleared.

The next step is member accounts with Supabase: `supabase/schema.sql` already sets up the tables, private photo storage, and security so each member can only see their own data.

## Files

| File | What it is |
| --- | --- |
| `index.html` | The whole app |
| `supabase/schema.sql` | Database for member accounts (next step) |
| `manifest.webmanifest`, `icon.svg` | Lets people add the app to their home screen |

## Putting it online (Vercel)

1. Sign in at [vercel.com](https://vercel.com) with GitHub.
2. **Add New → Project**, pick this repository, click **Deploy**.
3. Every change saved here updates the live app automatically.

## Roadmap (from the My Life Assistant deck)

1. **Simple App** (this): reflections, 10 photos a month, annual keepsake
2. **Expanded App:** local partner businesses join through an Explore Session, with profiles, events and member gifts
3. **All-in App:** ticketed experiences across partner businesses, tiered pricing, transport and gifting

Content comes from Candyce's My Life Assistant deck, the My Life Planner reflection pages, and The Castler Club App spreadsheet.
