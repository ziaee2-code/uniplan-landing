const nodemailer = require('nodemailer');

module.exports = async (req, res) => {
    if (req.method !== 'POST') {
        return res.status(405).json({ message: 'Method not allowed' });
    }
    const { name, email, message } = req.body;

    let transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.GMAIL_USER,
            pass: process.env.GMAIL_PASS
        }
    });

    try {
        await transporter.sendMail({
            from: email,
            to: 'ziaee2@gmail.com',
            subject: `New Contact Form Submission from ${name}`,
            text: message
        });
        res.status(200).json({ message: 'Message sent successfully!' });
    } catch (err) {
        res.status(500).json({ message: 'Failed to send message.' });
    }
};
