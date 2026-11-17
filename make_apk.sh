#!/bin/bash

echo "🚀 বাংলা গ্লাস ক্যালকুলেটর APK তৈরির কাজ শুরু হচ্ছে..."

# ১. প্রজেক্ট ফোল্ডার ও প্রয়োজনীয় প্যাকেজ ইনস্টল
mkdir -p www
cat << 'PKG' > package.json
{
  "name": "bangla-glass-calculator",
  "version": "1.0.0",
  "dependencies": {
    "@capacitor/android": "^6.0.0",
    "@capacitor/cli": "^6.0.0",
    "@capacitor/core": "^6.0.0"
  }
}
PKG

cat << 'CAP' > capacitor.config.json
{
  "appId": "com.bangla.glasscalc",
  "appName": "বাংলা ক্যালকুলেটর",
  "webDir": "www"
}
CAP

# ২. মূল অ্যাপের কোড (HTML + CSS + JS) তৈরি
cat << 'HTML' > www/index.html
<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>বাংলা ক্যালকুলেটর</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@500;600;700&display=swap');
  :root {
    --glass-bg: rgba(255, 255, 255, 0.14);
    --glass-border: rgba(255, 255, 255, 0.28);
    --btn-bg: rgba(255, 255, 255, 0.12);
    --btn-hover: rgba(255, 255, 255, 0.25);
    --accent-blue: rgba(14, 165, 233, 0.65);
    --accent-green: rgba(16, 185, 129, 0.65);
    --text-color: #ffffff;
  }
  * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'Hind Siliguri', sans-serif;
    -webkit-tap-highlight-color: transparent;
    user-select: none;
  }
  body {
    background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 45%, #311042 100%);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    color: var(--text-color);
    padding: 8px;
  }
  .calc-container {
    width: 100%;
    max-width: 420px;
    height: 96vh;
    max-height: 840px;
    background: var(--glass-bg);
    backdrop-filter: blur(18px);
    -webkit-backdrop-filter: blur(18px);
    border: 1.5px solid var(--glass-border);
    border-radius: 26px;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
    display: flex;
    flex-direction: column;
    padding: 14px;
    gap: 10px;
  }
  .history-box {
    flex: 1;
    background: rgba(0, 0, 0, 0.25);
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-radius: 16px;
    padding: 8px 12px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
  }
  .history-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 13px;
    color: #cbd5e1;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    padding-bottom: 4px;
    margin-bottom: 6px;
  }
  .clear-hist-btn {
    background: rgba(239, 68, 68, 0.4);
    border: 1px solid rgba(239, 68, 68, 0.6);
    color: #fff;
    padding: 2px 8px;
    border-radius: 8px;
    font-size: 11px;
  }
  .history-list {
    display: flex;
    flex-direction: column;
    gap: 5px;
    font-size: 15px;
  }
  .history-item {
    display: flex;
    justify-content: space-between;
    background: rgba(255, 255, 255, 0.07);
    padding: 5px 10px;
    border-radius: 8px;
  }
  .display-box {
    background: rgba(0, 0, 0, 0.35);
    border: 1px solid rgba(255, 255, 255, 0.25);
    border-radius: 18px;
    padding: 10px 14px;
    text-align: right;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    min-height: 110px;
  }
  .status-bar {
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #94a3b8;
  }
  .badge {
    background: rgba(255, 255, 255, 0.15);
    padding: 1px 7px;
    border-radius: 6px;
    color: #38bdf8;
    font-weight: 600;
  }
  .sub-expression {
    font-size: 16px;
    color: #cbd5e1;
    min-height: 22px;
    overflow-x: auto;
    white-space: nowrap;
  }
  .main-output {
    font-size: 38px;
    font-weight: 700;
    line-height: 1.15;
    overflow-x: auto;
    white-space: nowrap;
    color: #ffffff;
  }
  .keypad {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    grid-template-rows: repeat(6, 1fr);
    gap: 7px;
    flex: 2.3;
  }
  button.key {
    background: var(--btn-bg);
    border: 1px solid var(--glass-border);
    border-radius: 14px;
    color: #fff;
    font-size: 22px;
    font-weight: 600;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
  }
  button.key:active {
    transform: scale(0.93);
    background: var(--btn-hover);
  }
  .key-sm { font-size: 12px !important; line-height: 1.1; }
  .key-num { font-size: 26px !important; background: rgba(255, 255, 255, 0.18); }
  .key-ac { background: var(--accent-blue) !important; font-size: 19px !important; }
  .key-eq { background: var(--accent-green) !important; font-size: 26px !important; }
  .key-plus {
    grid-column: 4;
    grid-row: 5 / span 2;
    font-size: 32px !important;
    background: rgba(255, 255, 255, 0.22);
  }
</style>
</head>
<body>
<div class="calc-container">
  <div class="history-box">
    <div class="history-header">
      <span>হিসাবের ইতিহাস (Auto Saved)</span>
      <button class="clear-hist-btn" onclick="clearHistory()">মুছুন</button>
    </div>
    <div class="history-list" id="historyList"></div>
  </div>

  <div class="display-box">
    <div class="status-bar">
      <div><span class="badge" id="stepBadge">স্টেপ: ০১</span> <span class="badge" id="memBadge" style="display:none;">M</span></div>
      <div>১২ ডিজিট</div>
    </div>
    <div class="sub-expression" id="subDisplay"></div>
    <div class="main-output" id="mainDisplay">০</div>
  </div>

  <div class="keypad">
    <div style="grid-column: span 2; display:flex; align-items:center; padding-left:4px; font-size:12px; color:#cbd5e1; font-weight:600;">
      CITIZEN STYLE
    </div>
    <button class="key key-sm" onclick="stepCheck()">CHECK<br>→</button>
    <button class="key key-sm" onclick="autoReplay()">AUTO<br>REPLAY</button>
    <button class="key key-ac" onclick="allClear()">AC</button>

    <button class="key key-sm" onclick="calcMU()">MU</button>
    <button class="key key-sm" onclick="memRecallClear()">MRC</button>
    <button class="key key-sm" onclick="memSub()">M−</button>
    <button class="key key-sm" onclick="memAdd()">M+</button>
    <button class="key key-sm" onclick="backspace()">CORRECT<br>⌫</button>

    <button class="key key-num" onclick="inputNum('7')">৭</button>
    <button class="key key-num" onclick="inputNum('8')">৮</button>
    <button class="key key-num" onclick="inputNum('9')">৯</button>
    <button class="key" onclick="inputPercent()">%</button>
    <button class="key" onclick="calcSqrt()">√</button>

    <button class="key key-num" onclick="inputNum('4')">৪</button>
    <button class="key key-num" onclick="inputNum('5')">৫</button>
    <button class="key key-num" onclick="inputNum('6')">৬</button>
    <button class="key" onclick="inputOp('*')">×</button>
    <button class="key" onclick="inputOp('/')">÷</button>

    <button class="key key-num" onclick="inputNum('1')">১</button>
    <button class="key key-num" onclick="inputNum('2')">২</button>
    <button class="key key-num" onclick="inputNum('3')">৩</button>
    <button class="key key-plus" onclick="inputOp('+')">+</button>
    <button class="key" onclick="inputOp('-')">−</button>

    <button class="key key-num" onclick="inputNum('0')">০</button>
    <button class="key key-num" onclick="inputNum('00')">০০</button>
    <button class="key key-num" onclick="inputDot()">.</button>
    <button class="key key-eq" onclick="calculate()">=</button>
  </div>
</div>

<script>
  let currentInput = '0', prevValue = null, operator = null, resetNext = false;
  let memory = 0, mrcPressedOnce = false, steps = [], checkIndex = -1;
  let history = JSON.parse(localStorage.getItem('bn_calc_history')) || [];
  const bnDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

  function toBanglaDigits(str) {
    return str.toString().replace(/\d/g, d => bnDigits[d]);
  }

  function formatBanglaNumber(numStr) {
    if (numStr === 'Error' || numStr === 'ত্রুটি') return 'ত্রুটি';
    let isNegative = numStr.startsWith('-');
    if (isNegative) numStr = numStr.slice(1);
    let parts = numStr.split('.');
    let intPart = parts[0];
    let decPart = parts.length > 1 ? '.' + parts[1] : '';
    if (intPart.length > 3) {
      let lastThree = intPart.slice(-3);
      let otherNumbers = intPart.slice(0, -3).replace(/\B(?=(\d{2})+(?!\d))/g, ",");
      intPart = otherNumbers + ',' + lastThree;
    }
    return toBanglaDigits((isNegative ? '-' : '') + intPart + decPart);
  }

  function updateDisplay() {
    document.getElementById('mainDisplay').innerText = formatBanglaNumber(currentInput);
    let subText = '';
    if (prevValue !== null && operator) {
      const opSymbol = { '+': '+', '-': '−', '*': '×', '/': '÷' }[operator];
      subText = `${formatBanglaNumber(prevValue.toString())} ${opSymbol}`;
    }
    document.getElementById('subDisplay').innerText = subText;
    document.getElementById('stepBadge').innerText = `স্টেপ: ${toBanglaDigits(String(steps.length + 1).padStart(2, '0'))}`;
    document.getElementById('memBadge').style.display = memory !== 0 ? 'inline-block' : 'none';
  }

  function inputNum(num) {
    mrcPressedOnce = false;
    if (resetNext) {
      currentInput = (num === '00') ? '0' : num;
      resetNext = false;
    } else {
      if (currentInput === '0') currentInput = (num === '00') ? '0' : num;
      else if (currentInput.replace('.', '').length < 12) currentInput += num;
    }
    updateDisplay();
  }

  function inputDot() {
    mrcPressedOnce = false;
    if (resetNext) { currentInput = '0.'; resetNext = false; }
    else if (!currentInput.includes('.')) currentInput += '.';
    updateDisplay();
  }

  function backspace() {
    if (resetNext) return;
    currentInput = currentInput.length > 1 ? currentInput.slice(0, -1) : '0';
    if (currentInput === '-') currentInput = '0';
    updateDisplay();
  }

  function allClear() {
    currentInput = '0'; prevValue = null; operator = null;
    resetNext = false; steps = []; checkIndex = -1; mrcPressedOnce = false;
    updateDisplay();
  }

  function inputOp(op) {
    mrcPressedOnce = false;
    const currentVal = parseFloat(currentInput);
    if (prevValue === null) {
      prevValue = currentVal;
      steps.push({ val: currentVal, op: op });
    } else if (!resetNext) {
      const result = performMath(prevValue, currentVal, operator);
      prevValue = result;
      currentInput = String(result);
      steps.push({ val: currentVal, op: op });
    } else if (steps.length > 0) {
      steps[steps.length - 1].op = op;
    }
    operator = op; resetNext = true; updateDisplay();
  }

  function performMath(a, b, op) {
    let res = op === '+' ? a + b : op === '-' ? a - b : op === '*' ? a * b : (b === 0 ? 'Error' : a / b);
    return res === 'Error' ? 'Error' : Math.round(res * 100000000) / 100000000;
  }

  function calculate() {
    if (operator === null || prevValue === null) return;
    const currentVal = parseFloat(currentInput);
    const opSymbol = { '+': '+', '-': '−', '*': '×', '/': '÷' }[operator];
    const result = performMath(prevValue, currentVal, operator);
    steps.push({ val: currentVal, op: '=' });
    saveHistory(`${formatBanglaNumber(String(prevValue))} ${opSymbol} ${formatBanglaNumber(String(currentVal))}`, formatBanglaNumber(String(result)));
    currentInput = String(result); prevValue = null; operator = null; resetNext = true;
    updateDisplay();
  }

  function inputPercent() {
    const currentVal = parseFloat(currentInput);
    if (prevValue !== null && (operator === '+' || operator === '-')) currentInput = String((prevValue * currentVal) / 100);
    else currentInput = String(currentVal / 100);
    updateDisplay();
  }

  function calcSqrt() {
    const val = parseFloat(currentInput);
    if (val < 0) currentInput = 'Error';
    else {
      const res = Math.round(Math.sqrt(val) * 100000000) / 100000000;
      saveHistory(`√(${formatBanglaNumber(String(val))})`, formatBanglaNumber(String(res)));
      currentInput = String(res);
    }
    resetNext = true; updateDisplay();
  }

  function calcMU() {
    const currentVal = parseFloat(currentInput);
    if (prevValue !== null && currentVal !== 100) {
      const res = Math.round((prevValue / (1 - currentVal / 100)) * 100000) / 100000;
      saveHistory(`${formatBanglaNumber(String(prevValue))} MU ${formatBanglaNumber(String(currentVal))}%`, formatBanglaNumber(String(res)));
      currentInput = String(res); prevValue = null; operator = null; resetNext = true;
      updateDisplay();
    }
  }

  function memAdd() { memory += parseFloat(currentInput) || 0; resetNext = true; updateDisplay(); }
  function memSub() { memory -= parseFloat(currentInput) || 0; resetNext = true; updateDisplay(); }
  function memRecallClear() {
    if (mrcPressedOnce) { memory = 0; mrcPressedOnce = false; }
    else { currentInput = String(memory); mrcPressedOnce = true; resetNext = true; }
    updateDisplay();
  }

  function stepCheck() {
    if (steps.length === 0) return;
    checkIndex = (checkIndex + 1) % steps.length;
    currentInput = String(steps[checkIndex].val);
    document.getElementById('stepBadge').innerText = `চেক: ${toBanglaDigits(String(checkIndex + 1).padStart(2, '0'))}`;
    document.getElementById('mainDisplay').innerText = formatBanglaNumber(currentInput);
  }

  function autoReplay() {
    if (steps.length === 0) return;
    let i = 0;
    const interval = setInterval(() => {
      if (i >= steps.length) { clearInterval(interval); updateDisplay(); return; }
      document.getElementById('stepBadge').innerText = `রিপ্লে: ${toBanglaDigits(String(i + 1).padStart(2, '0'))}`;
      document.getElementById('mainDisplay').innerText = formatBanglaNumber(String(steps[i].val));
      i++;
    }, 700);
  }

  function saveHistory(expr, res) {
    if (res === 'ত্রুটি') return;
    history.unshift({ expr, res });
    if (history.length > 50) history.pop();
    localStorage.setItem('bn_calc_history', JSON.stringify(history));
    renderHistory();
  }

  function renderHistory() {
    document.getElementById('historyList').innerHTML = history.map(item => `
      <div class="history-item" onclick="useHistory('${item.res}')">
        <span style="color:#cbd5e1">${item.expr} =</span>
        <span style="font-weight:700; color:#38bdf8">${item.res}</span>
      </div>
    `).join('');
  }

  function useHistory(bnRes) {
    currentInput = bnRes.replace(/,/g, '').replace(/[০-৯]/g, d => bnDigits.indexOf(d));
    resetNext = false; updateDisplay();
  }

  function clearHistory() {
    history = []; localStorage.removeItem('bn_calc_history'); renderHistory();
  }

  renderHistory(); updateDisplay();
</script>
</body>
</html>
HTML

# ৩. Android SDK ও Java অটোমেটিক সেটআপ (যদি Codespace-এ না থাকে)
if [ ! -d "$HOME/android-sdk" ]; then
  echo "📦 Android SDK ডাউনলোড এবং সেটআপ হচ্ছে..."
  sudo apt-get update -y && sudo apt-get install -y openjdk-17-jdk unzip wget
  mkdir -p $HOME/android-sdk/cmdline-tools
  wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdtools.zip
  unzip -q cmdtools.zip -d $HOME/android-sdk/cmdline-tools
  mv $HOME/android-sdk/cmdline-tools/cmdline-tools $HOME/android-sdk/cmdline-tools/latest
  rm cmdtools.zip
  export ANDROID_HOME=$HOME/android-sdk
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
  yes | sdkmanager --licenses > /dev/null 2>&1
  sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
fi

export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# ৪. Capacitor বিল্ড ও APK জেনারেশন
echo "⚙️ Capacitor প্রজেক্ট তৈরি হচ্ছে..."
npm install
npx cap add android
npx cap sync

echo "🔨 APK বিল্ড করা হচ্ছে..."
cd android
chmod +x gradlew
./gradlew assembleDebug
cd ..

cp android/app/build/outputs/apk/debug/app-debug.apk ./Bangla-Calculator.apk
echo "✅ সফলভাবে APK তৈরি হয়েছে! বাম পাশের ফাইল লিস্ট থেকে 'Bangla-Calculator.apk' ডাউনলোড করুন।"
