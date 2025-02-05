<!-- Footer -->
<footer class="text-center text-lg-start bg-body-tertiary">

  <!-- Section: Links -->
  <section class="pt-5">
    <hr style="width: 100%; color: #EF923E;">
    <div class="container text-center text-md-start p-0" id="fc">

      <!-- Grid row -->
      <div class="row mt-3">
        <!-- Grid column -->
        <div class="col-md-4 col-lg-3 col-xl-3 ps-0">
          <!-- Content -->
          <img src="assets/img/beginwiseLogo.svg" alt="" height="300px" width="300px" id="fimg" class="mb-4 mt-0">
        </div>

        <!-- Grid column -->
        <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
          <!-- Links -->
          <h6 class="text-uppercase fw-bold mt-5 pt-4" style="color:#EF923E">
            Useful links
          </h6>
          <p>
            <a href="schoolfinder.html" class="text-reset fl">School Finder</a>
          </p>
          <p>
            <a href="prephub.html" class="text-reset fl">Prephub</a>
          </p>
          <p>
            <a href="about.html" class="text-reset fl">About Us</a>
          </p>

          <p>
            <a href="#!" class="text-reset fl">Contact Us</a>
          </p>

        </div>
        <!-- Grid column -->

        <!-- Grid column -->
        <div class="col-md-4 col-lg-5 col-xl-3 mx-auto mb-md-0 mb-4">
          <!-- Links -->
          <h6 class="text-uppercase fw-bold mt-5 pt-4" style="color:#EF923E">Contact</h6>
          <a href="mailto:beginwise61@gmail.com" class="fl" target="_blank">
            <p style="color: black;"><i class="fas fa-envelope me-3" style="color:#EF923E"></i>
              info@example.com
            </p>
          </a>
          <a href="tel:03002468949" class="fl" target="_blank">
            <p style="color: black;"><i class="fas fa-phone me-3" style="color:#EF923E"></i> 03002468949</p>
          </a>
          <a href="https://www.facebook.com/beginwise" class="fl" target="_blank">
            <p style="color: black;"><i class="fa-brands fa-square-facebook" style="color:#EF923E; font-size: 20px;"></i>&nbsp;&nbsp;&nbsp; Begin Wise</p>
          </a>
          <a href="https://www.instagram.com/begin_wise?igsh=NDJrMGRnb296cXZ0" class="fl" target="_blank">
            <p style="color: black;"><i class="fa-brands fa-square-instagram" style="color:#EF923E; font-size: 20px;"></i>&nbsp;&nbsp;&nbsp; begin_wise</p>
          </a>
        </div>
        <!-- Grid column -->
      </div>
      <!-- Grid row -->
    </div>
  </section>
  <!-- Section: Links -->

  <!-- Copyright -->
  <div class="text-center text-light p-4" style="background-color:#EF923E">
    &copy; 2024 Copyright:
    <a class="text-reset fw-bold" href="Recommendation.html">BeginWise</a>
  </div>
  <!-- Copyright -->
</footer>
<!-- Footer -->


<!-- Chat Toggle Button -->
<button id="chat-toggle">💬</button>

<!-- Chat Window -->
<div id="chat-window">
    <div id="chat-header">Beginwise Chatbot</div>
    <div id="chat-body">
        <div class="message bot-message">Chatbot: Hi! Ask me anything about Beginwise. Type 'exit' or 'quit' to end the chat.</div>
    </div>
    <div id="question-recommendations">
        <!-- Recommended Questions -->
        <span class="recommended-question">What is Beginwise?</span>
        <span class="recommended-question">How can Beginwise help my child's education?</span>
        <span class="recommended-question">What age groups does Beginwise cater to?</span>
        <span class="recommended-question">Tell me about the School Recommendation feature.</span>
        <span class="recommended-question">How does the Parental Interview Preparation work?</span>
    </div>
    <div id="chat-footer">
        <input type="text" id="chat-input" placeholder="Type your message..." />
        <button id="send-button">Send</button>
    </div>
</div>

<!-- JavaScript -->
<script>
    // Responses similar to the Python version
    const responses = {
        "what is beginwise": "Beginwise is an educational platform designed to provide young learners with engaging and interactive learning experiences. It offers tools like school recommendations, admission test preparation, and fun learning games, tailored for children aged 1 to 8.",
        "how can beginwise help my child's education": "Beginwise helps your child by offering personalized learning modules, interactive quizzes, and hands-on worksheets that make learning fun and effective.",
        "what age groups does beginwise cater to": "Beginwise caters to children aged 1 to 6, covering the educational needs of students from Playgroup to Grade 1.",
        "tell me about the school recommendation feature": "The School Recommendation feature helps parents find the best schools for their children based on factors such as location, board, and fee structure, making the school selection process easier.",
        "how does the parental interview preparation work": "Our Parental Interview Preparation module offers guidance and practice questions to help parents prepare for school admission interviews, building confidence and ensuring you are well-prepared.",
        // Add other questions and responses here...
        "default": "I'm not sure how to respond to that. Can you please provide more details?"
    };

    // Chat toggle functionality
    const chatToggle = document.getElementById('chat-toggle');
    const chatWindow = document.getElementById('chat-window');
    chatToggle.addEventListener('click', () => {
        chatWindow.style.display = chatWindow.style.display === 'none' || chatWindow.style.display === '' ? 'flex' : 'none';
    });

    // Chatbot logic
    const chatInput = document.getElementById('chat-input');
    const chatBody = document.getElementById('chat-body');
    const sendButton = document.getElementById('send-button');
    const recommendedQuestions = document.querySelectorAll('.recommended-question');

    function getResponse(message) {
        const lowerMessage = message.toLowerCase();
        for (const key in responses) {
            if (lowerMessage.includes(key)) {
                return responses[key];
            }
        }
        return responses['default'];
    }

    function appendMessage(content, isUser) {
        const messageDiv = document.createElement('div');
        messageDiv.classList.add('message', isUser ? 'user-message' : 'bot-message');
        messageDiv.textContent = content;
        chatBody.appendChild(messageDiv);
        chatBody.scrollTop = chatBody.scrollHeight;  // Scroll to the bottom
    }

    function handleUserInput() {
        const userMessage = chatInput.value.trim();
        if (userMessage) {
            appendMessage(`You: ${userMessage}`, true);
            const botResponse = getResponse(userMessage);
            appendMessage(`Chatbot: ${botResponse}`, false);
            chatInput.value = '';  // Clear input field
        }
    }

    sendButton.addEventListener('click', handleUserInput);

    chatInput.addEventListener('keydown', (event) => {
        if (event.key === 'Enter') {
            handleUserInput();
        }
    });

    // Handle recommended questions click
    recommendedQuestions.forEach(question => {
        question.addEventListener('click', () => {
            chatInput.value = question.textContent;
            chatInput.focus();  // Set focus to the input field
        });
    });
</script>

</body>
</html>
