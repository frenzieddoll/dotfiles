#! /bin/python

import os
import openai

def chatGPT(msg):
    res = openai.ChatCompletion.create(model='gpt-3.5-turbo', messages=msg)
    ans = res['choices'][0]['message']['content'].strip()
    msg.append({'role': 'assistant', 'content': ans})

    if res['usage']['total_tokens'] > 3000:
        print('warning: total tokens {}',res['usage']['total_tokens'])
        msg.pop(1)
        msg.pop(1)

    return (msg, ans)

openai.api_key=os.environ["OPENAI_API_KEY"]

msg = [{'role': 'system', 'content': 'あなたは賢いAIです。'}]
while True:
    prompt = input('> ').strip()
    if prompt in ['quit', 'exit']:
        break
    msg.append({'role': 'user', 'content': prompt})
    (msg, ans) = chatGPT(msg)
    print(ans)
