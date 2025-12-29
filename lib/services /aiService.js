const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

async function matchFreelancer(jobDetails, freelancerProfile) {
  const model = genAI.getGenerativeModel({
    model: "gemini-1.5-flash",
  });

  const prompt = `
You are Karzee AI Matchmaking Engine.

Job Details:
${jobDetails}

Freelancer Profile:
${freelancerProfile}

Task:
1. Decide Match or No Match
2. Give a short 2-line reason
3. Give match score out of 100

Return JSON ONLY in this format:
{
  "decision": "",
  "score": "",
  "reason": ""
}
`;

  const result = await model.generateContent(prompt);
  const text = result.response.text();

  return JSON.parse(text);
}

module.exports = { matchFreelancer };
