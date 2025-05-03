package com.echanalling.service;

import com.echanalling.model.Message;
import java.sql.*;
import java.util.*;

public class MessageDAO {
    private Connection conn;

    public MessageDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean sendMessage(Message message) throws SQLException {
        String sql = "INSERT INTO messages (sender_id, receiver_id, message) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, message.getSenderId());
        ps.setInt(2, message.getReceiverId());
        ps.setString(3, message.getMessageContent());
        return ps.executeUpdate() > 0;
    }

    public boolean updateMessage(int messageId, String newContent, int userId) throws SQLException {
        String sql = "UPDATE messages SET message = ? WHERE id = ? AND sender_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, newContent);
        ps.setInt(2, messageId);
        ps.setInt(3, userId);
        return ps.executeUpdate() > 0;
    }

    public boolean deleteMessage(int messageId, int userId) throws SQLException {
        String sql = "DELETE FROM messages WHERE id = ? AND sender_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, messageId);
        ps.setInt(2, userId);
        return ps.executeUpdate() > 0;
    }

    public List<Message> getMessagesForUser(int userId) throws SQLException {
        String sql = "SELECT m.*, u.name as sender_name FROM messages m JOIN users u ON m.sender_id = u.id WHERE m.sender_id = ? OR m.receiver_id = ? ORDER BY m.sent_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setInt(2, userId);
        ResultSet rs = ps.executeQuery();

        List<Message> messages = new ArrayList<>();
        while (rs.next()) {
            Message m = new Message();
            m.setId(rs.getInt("id"));
            m.setSenderId(rs.getInt("sender_id"));
            m.setReceiverId(rs.getInt("receiver_id"));
            m.setMessageContent(rs.getString("message"));
            m.setSentAt(rs.getString("sent_at"));
            m.setSenderName(rs.getString("sender_name"));
            messages.add(m);
        }
        return messages;
    }
}
