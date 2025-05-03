<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Message Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-purple-100 via-blue-50 to-white min-h-screen">

<header class="bg-white shadow p-4 mb-6">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Messages</h1>
        <nav>
            <a href="index.jsp" class="text-blue-600 hover:underline">Home</a>
        </nav>
    </div>
</header>

<main class="container mx-auto p-6">
    <!-- Flash Messages -->
    <c:if test="${not empty success}">
        <div class="bg-green-200 text-green-800 p-4 rounded mb-4">${success}</div>
        <c:remove var="success" scope="session" />
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-200 text-red-800 p-4 rounded mb-4">${error}</div>
        <c:remove var="error" scope="session" />
    </c:if>

    <!-- Create/Edit -->
    <c:if test="${mode == 'create' || mode == 'edit'}">
        <div class="bg-white shadow rounded-xl p-6 mb-6">
            <h2 class="text-xl font-semibold text-purple-700 mb-4">
                <c:choose>
                    <c:when test="${mode == 'create'}">Create Message</c:when>
                    <c:otherwise>Edit Message</c:otherwise>
                </c:choose>
            </h2>
            <form action="${pageContext.request.contextPath}/messages" method="post">
                <input type="hidden" name="action" value="${mode == 'create' ? 'create' : 'update'}"/>
                <c:if test="${mode == 'edit'}">
                    <input type="hidden" name="id" value="${currentMessage.id}"/>
                </c:if>

                <input type="hidden" name="senderId" value="${sessionScope.userId}">
                <p class="text-sm text-gray-500 ml-1 mb-2">Sender ID: ${sessionScope.userId}</p>

                <!-- Specialization -->
                <label class="block mb-1">Specialization</label>
                <select id="specializationSelect" class="w-full border p-2 rounded mb-4">
                    <option value="">-- Select Specialization --</option>
                    <c:forEach var="spec" items="${specializations}">
                        <option value="${spec}">${spec}</option>
                    </c:forEach>
                </select>

                <!-- Doctor -->
                <label class="block mb-1">Doctor</label>
                <select name="receiverId" id="doctorSelect" class="w-full border p-2 rounded mb-4" required>
                    <option value="">-- Select a Doctor --</option>
                </select>

                <textarea name="message" placeholder="Message" class="w-full border p-2 rounded mb-4" required>${currentMessage.message}</textarea>

                <div class="text-right">
                    <a href="${pageContext.request.contextPath}/messages" class="bg-gray-300 px-4 py-2 rounded mr-2">Cancel</a>
                    <button type="submit" class="bg-purple-600 text-white px-4 py-2 rounded">
                        <c:choose>
                            <c:when test="${mode == 'create'}">Send</c:when>
                            <c:otherwise>Update</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </c:if>

    <!-- View -->
    <c:if test="${mode == 'view'}">
        <div class="bg-white shadow rounded-xl p-6 mb-6">
            <h2 class="text-xl font-semibold text-purple-700 mb-4">Message Details</h2>
            <p><strong>Sender:</strong> ${currentMessage.senderId}</p>
            <p><strong>Receiver:</strong> ${currentMessage.receiverId}</p>
            <p><strong>Message:</strong> ${currentMessage.message}</p>
            <p><strong>Sent At:</strong> ${currentMessage.sentAt}</p>
            <div class="text-right mt-4">
                <a href="${pageContext.request.contextPath}/messages" class="bg-purple-600 text-white px-4 py-2 rounded">Back</a>
            </div>
        </div>
    </c:if>

    <!-- List -->
    <c:if test="${mode == 'list'}">
        <div class="bg-white shadow rounded-xl">
            <div class="flex justify-between items-center p-4 border-b">
                <h2 class="text-xl font-semibold text-gray-800">All Messages</h2>
                <a href="${pageContext.request.contextPath}/messages?mode=create" class="bg-purple-600 text-white px-4 py-2 rounded">+ New</a>
            </div>
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="px-6 py-3 text-left">Sender</th>
                        <th class="px-6 py-3 text-left">Receiver</th>
                        <th class="px-6 py-3 text-left">Message</th>
                        <th class="px-6 py-3 text-left">Sent At</th>
                        <th class="px-6 py-3 text-left">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="msg" items="${messages}">
                        <tr>
                            <td class="px-6 py-4">${msg.senderId}</td>
                            <td class="px-6 py-4">${msg.receiverId}</td>
                            <td class="px-6 py-4">${msg.message}</td>
                            <td class="px-6 py-4">${msg.sentAt}</td>
                            <td class="px-6 py-4">
                                <a href="${pageContext.request.contextPath}/messages?mode=view&id=${msg.id}" class="text-blue-600 hover:underline mr-2">View</a>
                                <a href="${pageContext.request.contextPath}/messages?mode=edit&id=${msg.id}" class="text-yellow-600 hover:underline mr-2">Edit</a>
                                <form action="${pageContext.request.contextPath}/messages" method="post" class="inline">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="id" value="${msg.id}"/>
                                    <button type="submit" class="text-red-600 hover:underline" onclick="return confirm('Delete this message?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty messages}">
                        <tr><td colspan="5" class="text-center text-gray-500 py-4">No messages found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </c:if>
</main>

<script>
    const doctorsBySpecialization = {
        <c:forEach var="entry" items="${doctorsBySpecialization}" varStatus="loop">
            "${entry.key}": [
                <c:forEach var="doc" items="${entry.value}" varStatus="docLoop">
                    { id: "${doc.id}", name: "${doc.name}" }<c:if test="${!docLoop.last}">,</c:if>
                </c:forEach>
            ]<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    };

    document.getElementById('specializationSelect').addEventListener('change', function () {
        const selectedSpec = this.value;
        const doctorSelect = document.getElementById('doctorSelect');
        doctorSelect.innerHTML = '<option value="">-- Select a Doctor --</option>';
        if (doctorsBySpecialization[selectedSpec]) {
            doctorsBySpecialization[selectedSpec].forEach(doctor => {
                const opt = document.createElement('option');
                opt.value = doctor.id;
                opt.textContent = doctor.name;
                doctorSelect.appendChild(opt);
            });
        }
    });
</script>
</body>
</html>
